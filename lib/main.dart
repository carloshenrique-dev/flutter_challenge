import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:github_challenge/core/ui/theme/text_theme.dart';
import 'core/services/dependency_injection.dart';
import 'core/services/routing.dart';
import 'firebase_options.dart';

Future<void> main() async {
  //default configs
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //dependencies
  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      routerConfig: routes,
    );
  }
}
