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
    apiKey: 'AIzaSyCFzSwx-yYZEEjAPfEhHX2wEV2Y1pZGwEU',
    appId: '1:1055637594589:web:82771d104985a229cdd634',
    messagingSenderId: '1055637594589',
    projectId: 'monde-app-58f25',
    authDomain: 'monde-app-58f25.firebaseapp.com',
    databaseURL: 'https://monde-app-58f25-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'monde-app-58f25.firebasestorage.app',
    measurementId: 'G-XKGT4TLMBV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBc-QljKWCZMNpUWTVQRKfGSdi0jay5twQ',
    appId: '1:1055637594589:android:5ca07fbfe0043b3fcdd634',
    messagingSenderId: '1055637594589',
    projectId: 'monde-app-58f25',
    databaseURL: 'https://monde-app-58f25-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'monde-app-58f25.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDApYtaZVW-_zz9rFP_mDj8O0P7BnwN-qg',
    appId: '1:1055637594589:ios:3ec67b132ede58accdd634',
    messagingSenderId: '1055637594589',
    projectId: 'monde-app-58f25',
    databaseURL: 'https://monde-app-58f25-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'monde-app-58f25.firebasestorage.app',
    iosClientId: '1055637594589-b2nv0dfc5l2mc2qpssu3k454t1fqkkmv.apps.googleusercontent.com',
    iosBundleId: 'com.example.mondeApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDApYtaZVW-_zz9rFP_mDj8O0P7BnwN-qg',
    appId: '1:1055637594589:ios:3ec67b132ede58accdd634',
    messagingSenderId: '1055637594589',
    projectId: 'monde-app-58f25',
    databaseURL: 'https://monde-app-58f25-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'monde-app-58f25.firebasestorage.app',
    iosClientId: '1055637594589-b2nv0dfc5l2mc2qpssu3k454t1fqkkmv.apps.googleusercontent.com',
    iosBundleId: 'com.example.mondeApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCFzSwx-yYZEEjAPfEhHX2wEV2Y1pZGwEU',
    appId: '1:1055637594589:web:955cf1e7f84a83dfcdd634',
    messagingSenderId: '1055637594589',
    projectId: 'monde-app-58f25',
    authDomain: 'monde-app-58f25.firebaseapp.com',
    databaseURL: 'https://monde-app-58f25-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'monde-app-58f25.firebasestorage.app',
    measurementId: 'G-Z3T9LBXY4J',
  );
}
