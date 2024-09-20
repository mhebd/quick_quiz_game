import 'package:flutter/material.dart';
import 'package:quick_quiz_game/pages/game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState();

  double currentDifficulty = 0;
  List<String> difficulties = ['Easy', 'Medium', 'Hard'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          children: [
            _renderAppName(),
            _renderDifficultyLavel(),
          ],
        ),
        SizedBox(
          width: 320,
          child: _renderDifficultySlide(),
        ),
        _renderStartButton()
      ],
    ));
  }

  // Render difficulty
  Widget _renderAppName() {
    return const Center(
      child: Text(
        'Quick Quiz',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Render difficulty
  Widget _renderDifficultyLavel() {
    return Center(
      child: Text(
        difficulties[currentDifficulty.round()],
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Render difficulty slide
  Widget _renderDifficultySlide() {
    return Center(
      child: Slider(
        label: 'Difficuilty lavel',
        min: 0,
        max: 2,
        divisions: 2,
        value: currentDifficulty,
        onChanged: (value) {
          setState(() {
            currentDifficulty = value;
          });
        },
      ),
    );
  }

  // Render start button
  Widget _renderStartButton() {
    return MaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return GamePage(
              difficulty: difficulties[currentDifficulty.round()],
            );
          }),
        );
      },
      color: const Color.fromRGBO(51, 51, 51, 1.0),
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
      child: const Text(
        'Start',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
