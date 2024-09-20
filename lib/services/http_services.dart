import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:quick_quiz_game/models/app_config.dart';

class HTTPServices {
  final Dio _dio = Dio();
  AppConfig? _appConfig;
  String? _apiBaseUrl;

  HTTPServices() {
    _appConfig = GetIt.instance.get<AppConfig>();
    _apiBaseUrl = _appConfig?.apiBaseUrl;
  }

  Future<Response> get(String difficulty) async {
    String url = _apiBaseUrl!.replaceFirst('{DIFFICULTY}', difficulty);
    Response response = await _dio.get(url);
    return response;
  }
}
