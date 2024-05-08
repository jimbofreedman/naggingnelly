import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:naggingnelly/todos_overview/todos_overview.dart';
import 'package:todos_repository/todos_repository.dart';

part 'todos_overview_event.dart';
part 'todos_overview_state.dart';

class TodosOverviewBloc extends Bloc<TodosOverviewEvent, TodosOverviewState> {
  TodosOverviewBloc({
    required TodosRepository todosRepository,
  })  : _todosRepository = todosRepository,
        super(const TodosOverviewState()) {
    on<TodosOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<TodosOverviewTodoCompleted>(_onTodoCompleted);
    on<TodosOverviewTodoDeleted>(_onTodoDeleted);
    on<TodosOverviewUndoDeletionRequested>(_onUndoDeletionRequested);
    on<TodosOverviewFilterChanged>(_onFilterChanged);
    on<TodosOverviewToggleAllRequested>(_onToggleAllRequested);
    on<TodosOverviewClearCompletedRequested>(_onClearCompletedRequested);
  }

  final TodosRepository _todosRepository;

  Future<void> _onSubscriptionRequested(
    TodosOverviewSubscriptionRequested event,
    Emitter<TodosOverviewState> emit,
  ) async {
    emit(state.copyWith(status: () => TodosOverviewStatus.loading));

    await emit.forEach<List<Todo>>(
      _todosRepository.getTodos(),
      onData: (todos) => state.copyWith(
        status: () => TodosOverviewStatus.success,
        todos: () => todos,
      ),
      // onError: (_, __) => state.copyWith(
      //   status: () => TodosOverviewStatus.failure,
      // ),
    );
  }

  Future<void> _onTodoCompleted(
    TodosOverviewTodoCompleted event,
    Emitter<TodosOverviewState> emit,
  ) async {
    var streak = event.todo.streak;
    var streakSavers = event.todo.streakSavers;
    final streakHistory = event.todo.streakHistory;

    if (event.todo.startAt != null && event.todo.dueAt != null) {
      streak = (event.todo.streak ?? 0) + 1;
      if (streak % 7 == 0) {
        streakSavers = (event.todo.streakSavers ?? 0) + 1;
      }
      streakHistory[event.todo.startAt!] = DateTime.now();
    }
    final startAt = event.todo.startAt?.add(const Duration(days: 1));
    final dueAt = event.todo.dueAt?.add(const Duration(days: 1));

    final newTodo = event.todo.copyWith(
      startAt: startAt,
      dueAt: dueAt,
      streak: streak,
      streakSavers: streakSavers,
      streakHistory: streakHistory,
    );

    await _todosRepository.saveTodo(newTodo);
  }

  Future<void> _onTodoDeleted(
    TodosOverviewTodoDeleted event,
    Emitter<TodosOverviewState> emit,
  ) async {
    emit(state.copyWith(lastDeletedTodo: () => event.todo));
    await _todosRepository.deleteTodo(event.todo.id!);
  }

  Future<void> _onUndoDeletionRequested(
    TodosOverviewUndoDeletionRequested event,
    Emitter<TodosOverviewState> emit,
  ) async {
    assert(
      state.lastDeletedTodo != null,
      'Last deleted todo can not be null.',
    );

    final todo = state.lastDeletedTodo!;
    emit(state.copyWith(lastDeletedTodo: () => null));
    await _todosRepository.saveTodo(todo);
  }

  void _onFilterChanged(
    TodosOverviewFilterChanged event,
    Emitter<TodosOverviewState> emit,
  ) {
    emit(state.copyWith(filter: () => event.filter));
  }

  Future<void> _onToggleAllRequested(
    TodosOverviewToggleAllRequested event,
    Emitter<TodosOverviewState> emit,
  ) async {
    final areAllCompleted = state.todos.every((todo) => todo.isCompleted);
    await _todosRepository.completeAll(isCompleted: !areAllCompleted);
  }

  Future<void> _onClearCompletedRequested(
    TodosOverviewClearCompletedRequested event,
    Emitter<TodosOverviewState> emit,
  ) async {
    await _todosRepository.clearCompleted();
  }
}
