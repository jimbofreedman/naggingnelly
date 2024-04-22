// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options_development.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDw3iV9zxPqYYW1JZAVF7sCKCh9nLBCm0k',
    appId: '1:114263892494:web:1a942d17eefdf5d8ab925f',
    messagingSenderId: '114263892494',
    projectId: 'naggingnelly-dev',
    authDomain: 'naggingnelly-dev.firebaseapp.com',
    storageBucket: 'naggingnelly-dev.appspot.com',
    measurementId: 'G-K2C4Y2FMYN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyATOvarJs5OInQju9VVxsZfEM117c0EKfI',
    appId: '1:114263892494:android:1cc8c5c675a2225dab925f',
    messagingSenderId: '114263892494',
    projectId: 'naggingnelly-dev',
    storageBucket: 'naggingnelly-dev.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBgm1sW0WozQ4cktW24AgIrpl0dhN1pWag',
    appId: '1:114263892494:ios:3f32c7734aa8ea87ab925f',
    messagingSenderId: '114263892494',
    projectId: 'naggingnelly-dev',
    storageBucket: 'naggingnelly-dev.appspot.com',
    iosClientId:
        '114263892494-l8u25d8luii29nf28dhh9nqv7l7kna03.apps.googleusercontent.com',
    iosBundleId: 'io.freedman.naggingnelly.dev',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBgm1sW0WozQ4cktW24AgIrpl0dhN1pWag',
    appId: '1:114263892494:ios:14824cd5a8a2f71fab925f',
    messagingSenderId: '114263892494',
    projectId: 'naggingnelly-dev',
    storageBucket: 'naggingnelly-dev.appspot.com',
    iosClientId:
        '114263892494-q4d2hpl65q1gaoinst2194g75ul8tqj0.apps.googleusercontent.com',
    iosBundleId: 'com.example.myApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDw3iV9zxPqYYW1JZAVF7sCKCh9nLBCm0k',
    appId: '1:114263892494:web:e2eb26a17fd606efab925f',
    messagingSenderId: '114263892494',
    projectId: 'naggingnelly-dev',
    authDomain: 'naggingnelly-dev.firebaseapp.com',
    storageBucket: 'naggingnelly-dev.appspot.com',
    measurementId: 'G-5KZNESRKMG',
  );
}
