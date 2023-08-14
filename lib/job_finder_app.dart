import 'package:flutter/material.dart';
import 'package:find_job/start_screen.dart';

class JobFinderApp extends StatelessWidget {
  const JobFinderApp({super.key});
  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(249, 4, 80, 42),
              Color.fromARGB(255, 6, 65, 45)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: const StartScreen(),
        ),
      ),
    );
  }
}
