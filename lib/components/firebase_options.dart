// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBfMIgoLR8rluxA8-E4V5QiDW8Tj6J6pZg',
    appId: '1:346034015437:web:547caa6baf793c61fe6d84',
    messagingSenderId: '346034015437',
    projectId: 'a-calculator-with-login',
    authDomain: 'a-calculator-with-login.firebaseapp.com',
    storageBucket: 'a-calculator-with-login.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyChzJ26lXGCyTQpJEbKd9PgImi5N7-I5qA',
    appId: '1:346034015437:android:539df10e644e38a2fe6d84',
    messagingSenderId: '346034015437',
    projectId: 'a-calculator-with-login',
    storageBucket: 'a-calculator-with-login.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAxYhlZhaYlEomTM1f7wcqjDvKJD3FB9jA',
    appId: '1:346034015437:ios:ac2f68424e1eb532fe6d84',
    messagingSenderId: '346034015437',
    projectId: 'a-calculator-with-login',
    storageBucket: 'a-calculator-with-login.appspot.com',
    iosBundleId: 'com.example.newCalculator',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAxYhlZhaYlEomTM1f7wcqjDvKJD3FB9jA',
    appId: '1:346034015437:ios:8748f8c1d32d68e4fe6d84',
    messagingSenderId: '346034015437',
    projectId: 'a-calculator-with-login',
    storageBucket: 'a-calculator-with-login.appspot.com',
    iosBundleId: 'com.example.newCalculator.RunnerTests',
  );
}
