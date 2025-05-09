// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBsXIAQ4WssTY7v2XWAJS9o9FaLHrLMtrc',
    appId: '1:194011149390:web:f59fc889457013815cbf1f',
    messagingSenderId: '194011149390',
    projectId: 'dating-app-2ba44',
    authDomain: 'dating-app-2ba44.firebaseapp.com',
    storageBucket: 'dating-app-2ba44.firebasestorage.app',
    measurementId: 'G-NMSWPC5TKE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBooicxHAmJJ8xDFT5vqBioRW8PwWuASIc',
    appId: '1:194011149390:android:83d9ac7e2df532845cbf1f',
    messagingSenderId: '194011149390',
    projectId: 'dating-app-2ba44',
    storageBucket: 'dating-app-2ba44.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA9h8zm93YFSG5AYyKrktk67Vd6mZXMUZ4',
    appId: '1:194011149390:ios:4ce28b66d04a5f6c5cbf1f',
    messagingSenderId: '194011149390',
    projectId: 'dating-app-2ba44',
    storageBucket: 'dating-app-2ba44.firebasestorage.app',
    iosBundleId: 'com.example.datingApp',
  );
}
