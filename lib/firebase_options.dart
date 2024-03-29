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
    apiKey: 'AIzaSyDM_apKkj5O-UHzXNhAGCCTwxwS30gTI5U',
    appId: '1:118147644616:web:3474b4b337ac4d6f6b79fd',
    messagingSenderId: '118147644616',
    projectId: 'test-b08ed',
    authDomain: 'test-b08ed.firebaseapp.com',
    storageBucket: 'test-b08ed.appspot.com',
    measurementId: 'G-RMC9LZXR99',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCh-cNjOQgb9ZAzZN42AhWMJuohQKaVB4g',
    appId: '1:118147644616:android:a9aa220b649eca756b79fd',
    messagingSenderId: '118147644616',
    projectId: 'test-b08ed',
    storageBucket: 'test-b08ed.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCj_iUNBt-rLx2Ui472eI7_vAa9IrDnKTU',
    appId: '1:118147644616:ios:ec87d9b2c6cb493b6b79fd',
    messagingSenderId: '118147644616',
    projectId: 'test-b08ed',
    storageBucket: 'test-b08ed.appspot.com',
    iosBundleId: 'com.example.messagingApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCj_iUNBt-rLx2Ui472eI7_vAa9IrDnKTU',
    appId: '1:118147644616:ios:7f2369a6ed1157f16b79fd',
    messagingSenderId: '118147644616',
    projectId: 'test-b08ed',
    storageBucket: 'test-b08ed.appspot.com',
    iosBundleId: 'com.example.messagingApp.RunnerTests',
  );
}
