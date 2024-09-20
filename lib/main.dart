import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:quick_quiz_game/models/app_config.dart';
import 'package:quick_quiz_game/pages/home_page.dart';
import 'package:quick_quiz_game/services/http_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadConfig();
  registerHTTPServices();
  runApp(const MyApp());
}

Future<void> loadConfig() async {
  String configContent = await rootBundle.loadString('config/appConfig.json');
  Map configData = jsonDecode(configContent);

  GetIt.instance.registerSingleton<AppConfig>(
    AppConfig(apiBaseUrl: configData['BASE_API_URL']),
  );
}

void registerHTTPServices() {
  GetIt.instance.registerSingleton<HTTPServices>(HTTPServices());
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
