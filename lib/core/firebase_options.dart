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
    // if (kIsWeb) {
    //   return web;
    // }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      // case TargetPlatform.iOS:
      //   return ios;
      // case TargetPlatform.macOS:
      //   return macos;
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

  // static const FirebaseOptions web = FirebaseOptions(
  //   apiKey: 'AIzaSyBPXM_vuNKrUB-AeZM_rHbk_zLBihm1S1k',
  //   appId: '1:998151327314:web:c585842b6e9d20ec3dd98b',
  //   messagingSenderId: '998151327314',
  //   projectId: 'iyadatouna',
  //   authDomain: 'iyadatouna.firebaseapp.com',
  //   databaseURL: 'https://iyadatouna-default-rtdb.firebaseio.com',
  //   storageBucket: 'iyadatouna.appspot.com',
  //   measurementId: 'G-E775QGJM4Q',
  // );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA83FNFM5asVPRJjDOTOyLkbWPjKka4RQs',
    appId: '1:283609042447:android:eebe127e451c8809f01d7a',
    messagingSenderId: '283609042447',
    projectId: 'dietapp-613b4',
    databaseURL: 'https://dietapp-613b4-default-rtdb.firebaseio.com',
    // storageBucket: 'iyadatouna.appspot.com',
  );

  // static const FirebaseOptions ios = FirebaseOptions(
  //   apiKey: 'AIzaSyCOs-OuZ7zp1eEoVO0AbsABRLqKK04xQQA',
  //   appId: '1:998151327314:ios:35baf9b2d708da8b3dd98b',
  //   messagingSenderId: '998151327314',
  //   projectId: 'iyadatouna',
  //   databaseURL: 'https://iyadatouna-default-rtdb.firebaseio.com',
  //   storageBucket: 'iyadatouna.appspot.com',
  //   iosClientId: '998151327314-o7sj5eiq54d9bln325hr7g9hbeghv8h0.apps.googleusercontent.com',
  //   iosBundleId: 'com.das360.hayatona',
  // );

  // static const FirebaseOptions macos = FirebaseOptions(
  //   apiKey: 'AIzaSyCOs-OuZ7zp1eEoVO0AbsABRLqKK04xQQA',
  //   appId: '1:998151327314:ios:7d84d6f48c48a4013dd98b',
  //   messagingSenderId: '998151327314',
  //   projectId: 'iyadatouna',
  //   databaseURL: 'https://iyadatouna-default-rtdb.firebaseio.com',
  //   storageBucket: 'iyadatouna.appspot.com',
  //   iosClientId: '998151327314-t56psa1ohujjp6gtplq4epk1mab6c69q.apps.googleusercontent.com',
  //   iosBundleId: 'com.das360.hayatonaClinic',
  // );
}