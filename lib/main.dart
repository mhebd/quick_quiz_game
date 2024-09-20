import 'package:flutter/material.dart';
import 'package:quick_quiz_game/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quick Quiz Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Satisfy",
        scaffoldBackgroundColor: const Color.fromRGBO(31, 31, 31, 1.0),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
