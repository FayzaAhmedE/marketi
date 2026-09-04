import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioFactory {
  static Dio getDio() {
    Dio dio = Dio();

    dio.options = BaseOptions(
      baseUrl: 'https://supermarket-dan1.onrender.com/api/v1/',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          String? token = prefs.getString('user_token');

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
        onError: (error, handler) {
          return handler.next(error);
        },
      ),
    );

    return dio;
  }
}
