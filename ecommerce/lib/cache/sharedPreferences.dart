import 'package:shared_preferences/shared_preferences.dart';

class sharedPreferences {
  static SharedPreferences? preferences;
  static Future init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static setEmail(String a) {
    preferences!.setString("email", a);
  }

  static String getEmail() {
    return preferences!.getString("email") ?? "";
  }

  static setPassword(String a) {
    preferences!.setString("password", a);
  }

  static String getPassword() {
    return preferences!.getString("password") ?? "";
  }

  static setLogin(String a) {
    preferences!.setString("login", a);
  }

  static String getLogin() {
    return preferences!.getString("login") ?? "";
  }
}
