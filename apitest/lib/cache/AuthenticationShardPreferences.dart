import 'package:shared_preferences/shared_preferences.dart';

class sharedPreferences {
  static SharedPreferences? preferences;
  static Future init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static Future setName(String a) async {
    preferences!.setString("name", a);
  }

  static String getName() {
    return preferences!.getString("name") ?? "";
  }

  static Future setPassword(String a) async {
    preferences!.setString("password", a);
  }

  static String getPassword() {
    return preferences!.getString("password") ?? "";
  }

  static Future setID(String a) async {
    preferences!.setString("id", a);
  }

  static String getID() {
    return preferences!.getString("id") ?? "";
  }
}
