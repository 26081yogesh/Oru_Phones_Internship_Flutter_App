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
    apiKey: 'AIzaSyC3lVbK2wntdeoNlIikvQ0Wo5iiHn246ao',
    appId: '1:356851260387:web:68d7c3425d95db12b55ed6',
    messagingSenderId: '356851260387',
    projectId: 'internshiporuphonesapp',
    authDomain: 'internshiporuphonesapp.firebaseapp.com',
    storageBucket: 'internshiporuphonesapp.appspot.com',
    measurementId: 'G-B3KE48Q44E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDswjQnAbZhPtWbiomWEx0DhdOwbOsEx0Q',
    appId: '1:356851260387:android:a3bf157639739c0cb55ed6',
    messagingSenderId: '356851260387',
    projectId: 'internshiporuphonesapp',
    storageBucket: 'internshiporuphonesapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyArowry5QI_1bWEp9t-p2UjPx-J9jxG40o',
    appId: '1:356851260387:ios:2c872fa6a895d595b55ed6',
    messagingSenderId: '356851260387',
    projectId: 'internshiporuphonesapp',
    storageBucket: 'internshiporuphonesapp.appspot.com',
    iosClientId: '356851260387-ll20jsqcns9k5ib8fr15t1jo5ba0iub2.apps.googleusercontent.com',
    iosBundleId: 'com.example.internshipApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyArowry5QI_1bWEp9t-p2UjPx-J9jxG40o',
    appId: '1:356851260387:ios:4e218d0c11942eeeb55ed6',
    messagingSenderId: '356851260387',
    projectId: 'internshiporuphonesapp',
    storageBucket: 'internshiporuphonesapp.appspot.com',
    iosClientId: '356851260387-t5t0s17l5akd7ds1s8qom6pocvjq39d1.apps.googleusercontent.com',
    iosBundleId: 'com.example.internshipApp.RunnerTests',
  );
}
