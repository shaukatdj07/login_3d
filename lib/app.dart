import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '3D Auth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Orbitron'),
          bodyMedium: TextStyle(fontFamily: 'Orbitron'),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
