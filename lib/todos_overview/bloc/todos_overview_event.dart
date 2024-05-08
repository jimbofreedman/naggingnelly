part of 'todos_overview_bloc.dart';

sealed class TodosOverviewEvent extends Equatable {
  const TodosOverviewEvent();

  @override
  List<Object> get props => [];
}

final class TodosOverviewSubscriptionRequested extends TodosOverviewEvent {
  const TodosOverviewSubscriptionRequested();
}

final class TodosOverviewTodoCompleted extends TodosOverviewEvent {
  const TodosOverviewTodoCompleted({
    required this.todo,
  });

  final Todo todo;

  @override
  List<Object> get props => [todo];
}

final class TodosOverviewTodoDeleted extends TodosOverviewEvent {
  const TodosOverviewTodoDeleted(this.todo);

  final Todo todo;

  @override
  List<Object> get props => [todo];
}

final class TodosOverviewUndoDeletionRequested extends TodosOverviewEvent {
  const TodosOverviewUndoDeletionRequested();
}

class TodosOverviewFilterChanged extends TodosOverviewEvent {
  const TodosOverviewFilterChanged(this.filter);

  final TodosViewFilter filter;

  @override
  List<Object> get props => [filter];
}

class TodosOverviewToggleAllRequested extends TodosOverviewEvent {
  const TodosOverviewToggleAllRequested();
}

class TodosOverviewClearCompletedRequested extends TodosOverviewEvent {
  const TodosOverviewClearCompletedRequested();
}
