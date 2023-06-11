import 'package:business/core/network/end_points.dart';
import 'package:business/core/network/remote/api_caller.dart';

class ForgetPasswordRepo {
  static Future resetPasswordCode({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    return await ApiCaller.instance.requestPost(RESET_PASSWORD, (data) {
      return data;
    }, body: <String, dynamic>{
      "email": email,
      "new_password": password,
      "new_password_confirmation": confirmPassword,
    });
  }
}
