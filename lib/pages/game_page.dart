// ignore_for_file: no_logic_in_create_state, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quick_quiz_game/pages/home_page.dart';
import 'package:quick_quiz_game/services/http_services.dart';
import 'package:html/parser.dart' as html;

class GamePage extends StatefulWidget {
  final String difficulty;
  const GamePage({super.key, required this.difficulty});

  @override
  State<StatefulWidget> createState() => _GamePageState(difficulty: difficulty);
}

class _GamePageState extends State<GamePage> {
  final String difficulty;
  late double deviceHeight, deviceWidth;
  var http = GetIt.instance.get<HTTPServices>();
  late List questions = [];
  int currentQuestion = 0, rightAnswer = 0;
  bool isLoading = true;

  _GamePageState({required this.difficulty});

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    final response = await http.get(difficulty);
    var data = jsonDecode(response.toString());
    setState(() {
      questions = data['results'];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _renderQuestion(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _trueButton(),
              const SizedBox(height: 20),
              _falseButton(),
            ],
          )
        ],
      ),
    );
  }

  // Render question
  Widget _renderQuestion() {
    String question = questions[currentQuestion]['question'];
    String decodedText = html.parse(question).documentElement?.text ?? '';
    return SizedBox(
      width: deviceWidth,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          decodedText,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white70, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  // True button
  Widget _trueButton() {
    return MaterialButton(
      onPressed: () {
        if (questions[currentQuestion]['correct_answer'] == 'True') {
          rightAnswer++;
          _showAnsCurrectionDialog(true);
        } else {
          _showAnsCurrectionDialog(false);
        }
        setState(() {
          if (currentQuestion == 9) {
            _resultModal();
            return;
          }
          currentQuestion++;
        });
      },
      color: Colors.green,
      minWidth: deviceWidth * .6,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: const Text(
        'True',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // False button
  Widget _falseButton() {
    return MaterialButton(
      onPressed: () {
        if (questions[currentQuestion]['correct_answer'] == 'False') {
          rightAnswer++;
          _showAnsCurrectionDialog(true);
        } else {
          _showAnsCurrectionDialog(false);
        }
        setState(() {
          if (currentQuestion == 9) {
            _resultModal();
            return;
          }
          currentQuestion++;
        });
      },
      color: Colors.red,
      minWidth: deviceWidth * .6,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: const Text(
        'False',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Render question alert
  void _showAnsCurrectionDialog(bool correct) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Return the AlertDialog
        return AlertDialog(
          backgroundColor: correct ? Colors.green : Colors.red,
          content: SizedBox(
            height: 20,
            child: Center(
              child: correct
                  ? const Icon(Icons.check_circle_outline_outlined,
                      color: Colors.white)
                  : const Icon(Icons.close_rounded, color: Colors.white),
            ),
          ),
        );
      },
    );

    // Close the dialog after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context); // Close the dialog
    });
  }

  // Render final result
  void _resultModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Return the AlertDialog
        return AlertDialog(
          backgroundColor: Colors.blue,
          content: Text(
            'Your score is: $rightAnswer',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return const HomePage();
        }),
      );
    });
  }
}
