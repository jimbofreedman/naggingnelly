import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todos_api/todos_api.dart';

/// {@template firestore_todos_api}
/// A Flutter implementation of the [TodosApi] that uses Firestore.
/// {@endtemplate}
class FirestoreTodosApi extends TodosApi {
  /// {@macro firestore_todos_api}
  final CollectionReference _todosCollection =
      FirebaseFirestore.instance.collection('todos');

  @override
  Stream<List<Todo>> getTodos() {
    return _todosCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final Todo d = Todo.fromJson(doc.data()! as Map<String, dynamic>)
            .copyWith(id: doc.reference.id);
        return d;
      }).toList();
    });
  }

  @override
  Future<void> saveTodo(Todo todo) {
    if (todo.id != null) {
      return _todosCollection.doc(todo.id).update(todo.toJson());
    } else {
      return _todosCollection.add(todo.toJson());
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    return _todosCollection.doc(id).delete();
  }

  @override
  Future<int> clearCompleted() async {
    throw UnsupportedError("You can't hard delete Todos");
  }

  @override
  Future<int> completeAll({required bool isCompleted}) async {
    throw UnimplementedError("Not yet implemented");
  }

  @override
  Future<void> close() {
    // TODO: implement close
    throw UnimplementedError();
  }
}
