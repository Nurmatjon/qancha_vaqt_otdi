import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const QanchaVaqtOtdiApp());
}

class QanchaVaqtOtdiApp extends StatelessWidget {
  const QanchaVaqtOtdiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Qancha vaqt o‘tdi?',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}