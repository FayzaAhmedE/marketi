import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/network/api_constants.dart';
import '../models/user_model.dart';

class ProfileRepo {
  Future<UserModel> getProfile({required String token}) async {
    final response = await http.get(
      Uri.parse(ApiConstants.profile),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    } else {
      throw Exception('تعذر تحميل بيانات البروفايل');
    }
  }
}
