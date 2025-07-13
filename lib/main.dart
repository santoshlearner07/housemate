import 'package:flutter/material.dart';
import 'home_screen.dart'; // we'll create this

void main() {
  runApp(const HouseMateApp());
}

class HouseMateApp extends StatelessWidget {
  const HouseMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HouseMate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
