// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:agendamentos_app/env.dart';
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

  static FirebaseOptions web = FirebaseOptions(
    apiKey: Env.getApiKeyWeb,
    appId: Env.getAppIdWeb,
    messagingSenderId: '295588700886',
    projectId: 'agendamento-de-veiculos-51810',
    authDomain: 'agendamento-de-veiculos-51810.firebaseapp.com',
    storageBucket: 'agendamento-de-veiculos-51810.appspot.com',
    measurementId: 'G-8CFJVNMTE9',
  );

  static FirebaseOptions android = FirebaseOptions(
    apiKey: Env.getAppIdAndroid,
    appId: '1:295588700886:android:3a309c41631a3a362d1f77',
    messagingSenderId: '295588700886',
    projectId: 'agendamento-de-veiculos-51810',
    storageBucket: 'agendamento-de-veiculos-51810.appspot.com',
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: Env.getAppIdIos,
    appId: '1:295588700886:ios:046f033e5033241a2d1f77',
    messagingSenderId: '295588700886',
    projectId: 'agendamento-de-veiculos-51810',
    storageBucket: 'agendamento-de-veiculos-51810.appspot.com',
    iosClientId:
        '295588700886-a7b4l3p8ks0317fi24in6g1m1q5qsrp8.apps.googleusercontent.com',
    iosBundleId: 'com.example.agendamentosApp',
  );

  static FirebaseOptions macos = FirebaseOptions(
    apiKey: Env.getAppIdMac,
    appId: '1:295588700886:ios:046f033e5033241a2d1f77',
    messagingSenderId: '295588700886',
    projectId: 'agendamento-de-veiculos-51810',
    storageBucket: 'agendamento-de-veiculos-51810.appspot.com',
    iosClientId:
        '295588700886-a7b4l3p8ks0317fi24in6g1m1q5qsrp8.apps.googleusercontent.com',
    iosBundleId: 'com.example.agendamentosApp',
  );
}
