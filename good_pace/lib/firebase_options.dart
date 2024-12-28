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
    apiKey: 'AIzaSyAF9GE2vYThN5TEnWGh3ot3nOBMqL7OC9Y',
    appId: '1:951411201953:web:d962931d9ef9e4c4e21de0',
    messagingSenderId: '951411201953',
    projectId: 'goodpace-7c671',
    authDomain: 'goodpace-7c671.firebaseapp.com',
    storageBucket: 'goodpace-7c671.firebasestorage.app',
    measurementId: 'G-7R99P8C2XD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA6GpRq0kG8GZodS_o2VekKARbrPZuFiMw',
    appId: '1:951411201953:android:47823ff4825d64d3e21de0',
    messagingSenderId: '951411201953',
    projectId: 'goodpace-7c671',
    storageBucket: 'goodpace-7c671.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC3gNBOJugYkYhEIL4E9fnqRwk25FMKE_g',
    appId: '1:951411201953:ios:be826936ac3deb35e21de0',
    messagingSenderId: '951411201953',
    projectId: 'goodpace-7c671',
    storageBucket: 'goodpace-7c671.firebasestorage.app',
    iosBundleId: 'com.example.goodPace',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC3gNBOJugYkYhEIL4E9fnqRwk25FMKE_g',
    appId: '1:951411201953:ios:be826936ac3deb35e21de0',
    messagingSenderId: '951411201953',
    projectId: 'goodpace-7c671',
    storageBucket: 'goodpace-7c671.firebasestorage.app',
    iosBundleId: 'com.example.goodPace',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAF9GE2vYThN5TEnWGh3ot3nOBMqL7OC9Y',
    appId: '1:951411201953:web:60a49e10c3ec7e5ee21de0',
    messagingSenderId: '951411201953',
    projectId: 'goodpace-7c671',
    authDomain: 'goodpace-7c671.firebaseapp.com',
    storageBucket: 'goodpace-7c671.firebasestorage.app',
    measurementId: 'G-B8M47757SV',
  );
}
