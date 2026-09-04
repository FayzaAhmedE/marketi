import '../../../../core/network/api_constants.dart';
import '../../../../core/network/api_service.dart';

class AuthRepo {
  Future<Map<String, dynamic>> login({
    required String identifier,
    required String password,
  }) {
    return ApiService.post(
      url: ApiConstants.login,
      body: {'email': identifier, 'password': password},
    );
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    return ApiService.post(
      url: ApiConstants.register,
      body: {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
      },
    );
  }
}
