// main.dart
import 'package:flutter/material.dart';
import 'package:vitae_fitness/themes.dart';
import 'package:vitae_fitness/screens/login_page.dart';
import 'package:provider/provider.dart';
import 'package:vitae_fitness/services/providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ProfileProvider>(create: (_) => ProfileProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const LoginPage(),
    );
  }
}
