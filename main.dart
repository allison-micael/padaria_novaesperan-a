import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Padaria App',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: const HomeScreen(),
    );
  }
}
