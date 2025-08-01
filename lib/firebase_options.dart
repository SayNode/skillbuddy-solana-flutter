// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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
      // ignore: no_default_cases
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC9EDUS1DHdb7ND1ecRk14KKQKiG9Z_N_E',
    appId: '1:644593034419:android:da3c222457c96dd85afcc6',
    messagingSenderId: '644593034419',
    projectId: 'saynode-skillbuddy',
    storageBucket: 'saynode-skillbuddy.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyArskkiDXcd3g2EASbc9oA4IpZ_NwAfIhI',
    appId: '1:644593034419:ios:26813ae890d099c65afcc6',
    messagingSenderId: '644593034419',
    projectId: 'saynode-skillbuddy',
    storageBucket: 'saynode-skillbuddy.appspot.com',
    androidClientId:
        '644593034419-9usu6ttfmdrg9junuh35ss6fmq5dro13.apps.googleusercontent.com',
    iosClientId:
        '644593034419-ll9439rm978qreheudn30gntljmh8bu5.apps.googleusercontent.com',
    iosBundleId: 'io.skillbuddy.academy',
  );
}
