import 'package:business/core/network/end_points.dart';
import 'package:business/core/network/remote/api_caller.dart';
import 'package:business/profile/model/profile_model.dart';

class UserRepo {
  static Future<ProfileModel?> loginUserAccount(
      String email, String password) async {
    return await ApiCaller.instance.requestPost(
      LOGIN,
      (data) {
        print(data);
        return ProfileModel.fromJson(data["client"]);
      },
      onFailure: (data) {},
      body: <String, dynamic>{
        'email': email,
        'password': password,
      },
    );
  }
}
