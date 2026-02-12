import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static const String _placeholder = 'REPLACE_WITH_FIREBASE_VALUE';

  static bool get isConfigured {
    final options = currentPlatform;
    return options.apiKey != _placeholder &&
        options.appId != _placeholder &&
        options.projectId != _placeholder;
  }

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
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: _placeholder,
    appId: _placeholder,
    messagingSenderId: _placeholder,
    projectId: _placeholder,
    authDomain: 'REPLACE_WITH_FIREBASE_VALUE',
    storageBucket: 'REPLACE_WITH_FIREBASE_VALUE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: _placeholder,
    appId: _placeholder,
    messagingSenderId: _placeholder,
    projectId: _placeholder,
    storageBucket: 'REPLACE_WITH_FIREBASE_VALUE',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: _placeholder,
    appId: _placeholder,
    messagingSenderId: _placeholder,
    projectId: _placeholder,
    storageBucket: 'REPLACE_WITH_FIREBASE_VALUE',
    iosBundleId: 'REPLACE_WITH_FIREBASE_VALUE',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: _placeholder,
    appId: _placeholder,
    messagingSenderId: _placeholder,
    projectId: _placeholder,
    storageBucket: 'REPLACE_WITH_FIREBASE_VALUE',
    iosBundleId: 'REPLACE_WITH_FIREBASE_VALUE',
  );
}
