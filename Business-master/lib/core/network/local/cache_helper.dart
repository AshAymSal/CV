import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBoolData({required key, required value}) async {
    return await sharedPreferences.setBool(key, value);
  }

  static Future<bool> putStringData({required key, required value}) async {
    return await sharedPreferences.setString(key, value);
  }

  static Future<bool> putIntData({required key, required value}) async {
    return await sharedPreferences.setInt(key, value);
  }

  static bool? getBoolData({required key}) {
    return sharedPreferences.getBool(key);
  }

  static int? getIntData({required key}) {
    return sharedPreferences.getInt(key);
  }

  static String? getStringData({required key}) {
    return sharedPreferences.getString(key);
  }
}
