import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quick_quiz_game/services/http_services.dart';

class GamePage extends StatefulWidget {
  final String difficulty;
  const GamePage({super.key, required this.difficulty});

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _GamePageState(difficulty: difficulty);
}

class _GamePageState extends State<GamePage> {
  final String difficulty;
  late double deviceHeight, deviceWidth;
  var http = GetIt.instance.get<HTTPServices>();
  late List questions;
  int currentQuestion = 0, rightAnswer = 0;

  _GamePageState({required this.difficulty});

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: http.get(difficulty),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var data = jsonDecode(snapshot.data.toString());
            questions = data['results'];
            print(questions[0]);
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _renderQuestion(),
                  Column(
                    children: [
                      _trueButton(),
                      const SizedBox(
                        height: 20,
                      ),
                      _falseButton()
                    ],
                  )
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  // Render question
  Widget _renderQuestion() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        'Hello, this is your first question. Please answer carefully. Hyrry up!!',
        style: TextStyle(
            color: Colors.white70, fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }

  // True button
  Widget _trueButton() {
    return MaterialButton(
      onPressed: () {},
      color: Colors.green,
      minWidth: deviceWidth * .6,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: const Text(
        'True',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          fontFamily: '',
        ),
      ),
    );
  }

  // True button
  Widget _falseButton() {
    return MaterialButton(
      onPressed: () {},
      color: Colors.red,
      minWidth: deviceWidth * .6,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: const Text(
        'False',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          fontFamily: '',
        ),
      ),
    );
  }
}
