import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:naggingnelly/models/todo.dart';

class FirestoreService {
  final CollectionReference _todosCollection =
      FirebaseFirestore.instance.collection('todos');

  Stream<List<Todo>> getTodos() {
    return _todosCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Todo.fromJson(doc.id, doc.data()! as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<void> addTodo(Todo todo) {
    return _todosCollection.add(todo.toJson());
  }

  Future<void> updateTodo(Todo todo) {
    return _todosCollection.doc(todo.id).update(todo.toJson());
  }

  Future<void> deleteTodo(String todoId) {
    return _todosCollection.doc(todoId).delete();
  }
}
