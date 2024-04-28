import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:local_storage_todos_api/local_storage_todos_api.dart';
import 'package:naggingnelly/bootstrap.dart';
import 'package:naggingnelly/firebase_options_development.dart';

final Map<String, String> appSettings = {
  'googleClientId': '114263892494-jje4rupuh2qn2purcnl5255brr9b6lcr.apps.'
      'googleusercontent.com',
};

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'naggingnelly-dev',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter
  // framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  final todosApi = LocalStorageTodosApi(
    plugin: await SharedPreferences.getInstance(),
  );

  GlobalConfiguration().loadFromMap(appSettings);
  return bootstrap(todosApi: todosApi);
}
