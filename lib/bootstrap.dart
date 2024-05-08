import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:naggingnelly/app/app.dart';
import 'package:naggingnelly/app/app_bloc_observer.dart';
import 'package:todos_api/todos_api.dart';
import 'package:todos_repository/todos_repository.dart';

void bootstrap({required TodosApi todosApi}) {
  Bloc.observer = const AppBlocObserver();

  final todosRepository = TodosRepository(todosApi: todosApi);

  runApp(App(todosRepository: todosRepository));
}
