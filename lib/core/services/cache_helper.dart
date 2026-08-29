import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> saveBool({required String key, required bool value}) {
    return _prefs!.setBool(key, value);
  }

  static bool getBool({required String key}) {
    return _prefs?.getBool(key) ?? false;
  }
}
