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
    apiKey: 'AIzaSyD55-S-dOKVjqfyRDcXiz7W4liLa1geEA0',
    appId: '1:454659001435:web:47204b5d21bc3b3d6f437e',
    messagingSenderId: '454659001435',
    projectId: 'aminahub-18c2f',
    authDomain: 'aminahub-18c2f.firebaseapp.com',
    storageBucket: 'aminahub-18c2f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCFPH3IkwOwnXEAlrJnDUmuJt5Pth_AQFI',
    appId: '1:454659001435:android:026212516bffaafa6f437e',
    messagingSenderId: '454659001435',
    projectId: 'aminahub-18c2f',
    storageBucket: 'aminahub-18c2f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAf-EmTqRQQbSDlUYlVv-8cpWjsVRDt_QY',
    appId: '1:454659001435:ios:1b13d39c1f8a2f4b6f437e',
    messagingSenderId: '454659001435',
    projectId: 'aminahub-18c2f',
    storageBucket: 'aminahub-18c2f.appspot.com',
    iosBundleId: 'com.example.aminahub',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAf-EmTqRQQbSDlUYlVv-8cpWjsVRDt_QY',
    appId: '1:454659001435:ios:32ac7c2b0974860c6f437e',
    messagingSenderId: '454659001435',
    projectId: 'aminahub-18c2f',
    storageBucket: 'aminahub-18c2f.appspot.com',
    iosBundleId: 'com.example.aminahub.RunnerTests',
  );
}
