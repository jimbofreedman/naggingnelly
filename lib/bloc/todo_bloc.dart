import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:naggingnelly/firestore_service.dart';
import 'package:naggingnelly/models/todo.dart';

@immutable
abstract class TodoEvent {}

class LoadTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  AddTodo(this.todo);
  final Todo todo;
}

class UpdateTodo extends TodoEvent {
  UpdateTodo(this.todo);
  final Todo todo;
}

class DeleteTodo extends TodoEvent {
  DeleteTodo(this.todoId);
  final String todoId;
}

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  TodoLoaded(this.todos);
  final List<Todo> todos;
}

class TodoOperationSuccess extends TodoState {
  TodoOperationSuccess(this.message);
  final String message;
}

class TodoError extends TodoState {
  TodoError(this.errorMessage);
  final String errorMessage;
}

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc(this._firestoreService) : super(TodoInitial()) {
    on<LoadTodos>((event, emit) async {
      // try {
      //   emit(TodoLoading());
      final todos = await _firestoreService.getTodos().first;
      emit(TodoLoaded(todos));
      // } catch (e) {
      //   emit(TodoError('Failed to load todos.'));
      // }
    });

    on<AddTodo>((event, emit) async {
      emit(TodoLoading());
      await _firestoreService.addTodo(event.todo);
      emit(TodoOperationSuccess('Todo added successfully.'));
    });

    on<UpdateTodo>((event, emit) async {
      emit(TodoLoading());
      await _firestoreService.updateTodo(event.todo);
      emit(TodoOperationSuccess('Todo updated successfully.'));
    });

    on<DeleteTodo>((event, emit) async {
      emit(TodoLoading());
      await _firestoreService.deleteTodo(event.todoId);
      emit(TodoOperationSuccess('Todo deleted successfully.'));
    });
  }
  final FirestoreService _firestoreService;
}
