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
    apiKey: 'AIzaSyDqtNBWKvpHBxE2-lIlPEDfoszbYIkkkoE',
    appId: '1:413915329409:web:9ac8f150792e6c778d6e80',
    messagingSenderId: '413915329409',
    projectId: 'pastijeriko',
    authDomain: 'pastijeriko.firebaseapp.com',
    storageBucket: 'pastijeriko.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD8jRzk4UeGFCma_A7KY4K8v9UhyB3miRg',
    appId: '1:413915329409:android:d6904773d6a2c7ed8d6e80',
    messagingSenderId: '413915329409',
    projectId: 'pastijeriko',
    storageBucket: 'pastijeriko.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBGAO-9S4HNkFHDw_pOJnFNthzvACobka0',
    appId: '1:413915329409:ios:05cdeee23ddf5bd58d6e80',
    messagingSenderId: '413915329409',
    projectId: 'pastijeriko',
    storageBucket: 'pastijeriko.appspot.com',
    iosBundleId: 'com.learningx.advan.jeriko',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBGAO-9S4HNkFHDw_pOJnFNthzvACobka0',
    appId: '1:413915329409:ios:05cdeee23ddf5bd58d6e80',
    messagingSenderId: '413915329409',
    projectId: 'pastijeriko',
    storageBucket: 'pastijeriko.appspot.com',
    iosBundleId: 'com.learningx.advan.jeriko',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDqtNBWKvpHBxE2-lIlPEDfoszbYIkkkoE',
    appId: '1:413915329409:web:e8ec60232062077f8d6e80',
    messagingSenderId: '413915329409',
    projectId: 'pastijeriko',
    authDomain: 'pastijeriko.firebaseapp.com',
    storageBucket: 'pastijeriko.appspot.com',
  );
}
