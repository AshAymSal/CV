import 'dart:convert';

import 'package:business/profile/model/profile_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesServiceProvider =
    Provider<SharedPreferencesService>(((ref) => throw UnimplementedError()));

class SharedPreferencesService {
  SharedPreferencesService(this.sharedPreferences) {
    getUserData();
  }
  final SharedPreferences sharedPreferences;

  static const onboardingCompleteKey = 'onboardingComplete';
  static const userData = 'UserData';

  Future<void> setOnboardingComplete() async {
    await sharedPreferences.setBool(onboardingCompleteKey, true);
  }

  bool isOnboardingComplete() =>
      sharedPreferences.getBool(onboardingCompleteKey) ?? false;

  /// User Data
  Future setUserData(ProfileModel profileModel) async {
    try {
      await sharedPreferences.setString(
          userData, json.encode(profileModel.toJson()));
    } catch (e) {
      print(e.toString());
    }
  }

  ProfileModel? getUserData() {
    try {
      return ProfileModel.fromJson(
          json.decode(sharedPreferences.getString(userData) ?? ''));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
