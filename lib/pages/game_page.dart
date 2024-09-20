import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<StatefulWidget> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  _GamePageState();
  late double deviceHeight, deviceWidth;

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
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
    ));
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
