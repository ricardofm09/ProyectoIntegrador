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
    apiKey: 'AIzaSyCHYWw3z-mZHmL6ZpvumqgoW8SWohoeSKI',
    appId: '1:743041179743:web:6ced821336b9f3b4f23bea',
    messagingSenderId: '743041179743',
    projectId: 'greenflow-a9bb4',
    authDomain: 'greenflow-a9bb4.firebaseapp.com',
    storageBucket: 'greenflow-a9bb4.appspot.com',
    measurementId: 'G-VJ8PNTSGMK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA0wUGlzqwQW1tdcjcUMxh-iOx2MRUuN_U',
    appId: '1:743041179743:android:13ee2b267e960dc1f23bea',
    messagingSenderId: '743041179743',
    projectId: 'greenflow-a9bb4',
    storageBucket: 'greenflow-a9bb4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC7n9PxP-ZozUWH-8CUPvfw16-hUfACCwQ',
    appId: '1:743041179743:ios:ddb708cc65455b61f23bea',
    messagingSenderId: '743041179743',
    projectId: 'greenflow-a9bb4',
    storageBucket: 'greenflow-a9bb4.appspot.com',
    iosBundleId: 'com.example.greenflow',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC7n9PxP-ZozUWH-8CUPvfw16-hUfACCwQ',
    appId: '1:743041179743:ios:288d2b73deced5d4f23bea',
    messagingSenderId: '743041179743',
    projectId: 'greenflow-a9bb4',
    storageBucket: 'greenflow-a9bb4.appspot.com',
    iosBundleId: 'com.example.greenflow.RunnerTests',
  );
}
