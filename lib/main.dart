import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/app_config.dart';
import 'firebase_options.dart';
import 'presentation/app/app_providers.dart';
import 'presentation/app/app_root.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var useFirebase = false;

  if (DefaultFirebaseOptions.isConfigured) {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      useFirebase = true;
    } catch (error) {
      debugPrint('Firebase init failed, falling back to mock data: $error');
    }
  }

  runApp(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(
          AppConfig(useFirebase: useFirebase),
        ),
      ],
      child: const AppRoot(),
    ),
  );
}
