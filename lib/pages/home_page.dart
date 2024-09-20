import 'package:flutter/material.dart';
import 'package:quick_quiz_game/pages/game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return const GamePage();
              },
            ),
          );
        },
        child: const Text('Game Page'),
      ),
    );
  }
}
