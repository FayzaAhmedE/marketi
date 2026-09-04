import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:marketi/core/services/cache_helper.dart';
import '../../../../core/network/api_constants.dart';
import '../models/user_model.dart';

class ProfileRepo {
  Future<UserModel> getProfile() async {
    final token = CacheHelper.getString(key: 'token');
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/portfoilo/userData'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    } else {
      throw Exception('تعذر تحميل بيانات البروفايل');
    }
  }
}
