import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naggingnelly/auth/view/auth_gate.dart';
import 'package:naggingnelly/bloc/todo_bloc.dart';
import 'package:naggingnelly/firestore_service.dart';
import 'package:naggingnelly/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoBloc>(
          create: (context) => TodoBloc(FirestoreService()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          useMaterial3: true,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const AuthGate(),
      ),
    );
  }
}
