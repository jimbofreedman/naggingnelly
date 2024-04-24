import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naggingnelly/bloc/todo_bloc.dart';
import 'package:naggingnelly/models/todo.dart';
import 'package:uuid/uuid.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  void initState() {
    BlocProvider.of<TodoBloc>(context).add(LoadTodos());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todoBloc = BlocProvider.of<TodoBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<ProfileScreen>(
                  builder: (context) => ProfileScreen(
                    appBar: AppBar(
                      title: const Text('User Profile'),
                    ),
                    actions: [
                      SignedOutAction((context) {
                        Navigator.of(context).pop();
                      }),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoLoaded) {
            final todos = state.todos
                .where(
                  (Todo t) => (t.startAt ??
                          (DateTime.now().add(const Duration(days: 1))))
                      .isBefore(DateTime.now()),
                )
                .toList()
              ..sort((a, b) => (a.order - b.order).ceil());

            return ReorderableListView.builder(
              onReorder: (int oldIndex, int newIndex) {
                final todo = todos[oldIndex];

                if (newIndex == 0) {
                  todo.reorder(todos[newIndex].order - 1);
                } else if (newIndex == todos.length) {
                  todo.reorder(todos.last.order + 1);
                } else {
                  final task1 = todos[newIndex - 1];
                  final task2 = todos[newIndex];

                  final newOrder = (task1.order + task2.order) / 2;

                  todo.reorder(
                    newOrder != task1.order ? newOrder : task1.order + 1,
                  );
                }

                todoBloc.add(UpdateTodo(todo));
              },
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                  key: ValueKey(todo.id),
                  leading: ReorderableDragStartListener(
                    //<-- add this to leading
                    index: index,
                    child: const Icon(Icons.tiktok),
                  ),
                  title: Text(todo.title),
                  subtitle: Text(
                    '${todo.streak} - '
                    "${todo.dueAt?.toString() ?? ""}",
                  ),
                  isThreeLine: true,
                  trailing: PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: 'complete',
                          child: const Text(
                            'Complete',
                            style: TextStyle(fontSize: 13),
                          ),
                          onTap: () {
                            todo.complete();
                            todoBloc.add(UpdateTodo(todo));
                          },
                        ),
                        PopupMenuItem(
                          value: 'fail',
                          child: const Text(
                            'Fail',
                            style: TextStyle(fontSize: 13),
                          ),
                          onTap: () {
                            todo.fail();
                            todoBloc.add(UpdateTodo(todo));
                          },
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: const Text(
                            'Delete',
                            style: TextStyle(fontSize: 13),
                          ),
                          onTap: () {
                            todoBloc.add(DeleteTodo(todo.id));
                          },
                        ),
                      ];
                    },
                  ),
                  dense: true,
                );
              },
            );
          } else if (state is TodoOperationSuccess) {
            todoBloc.add(LoadTodos()); // Reload todos
            return Container(); // Or display a success message
          } else if (state is TodoError) {
            return Center(child: Text(state.errorMessage));
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTodoDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context) {
    final titleController = TextEditingController();
    showDialog<dynamic>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Todo'),
          content: TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Todo title'),
          ),
          actions: [
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: const Text('Add'),
              onPressed: () {
                final todo = Todo(
                  id: const Uuid().toString(),
                  title: titleController.text,
                  order: -1,
                  completed: false,
                  createdAt: DateTime.now(),
                  startAt: DateTime.parse('2024-04-22 04:00:00Z'),
                  dueAt: DateTime.parse('2024-04-22 23:59:59Z'),
                  streak: 0,
                  streakSavers: 0,
                  streakHistory: {},
                );
                BlocProvider.of<TodoBloc>(context).add(AddTodo(todo));
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
