import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'widgets/app_theme.dart';
import 'views/pages/auth_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: EEpediaZApp(),
    ),
  );
}

class EEpediaZApp extends StatelessWidget {
  const EEpediaZApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EEpedia Z',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const AuthWrapper(),
    );
  }
}
