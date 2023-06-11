import 'package:business/authintication/register/model/create_account_model.dart';
import 'package:business/core/network/end_points.dart';
import 'package:business/core/network/remote/api_caller.dart';
import 'package:business/core/network/remote/api_request.dart';
import 'package:business/profile/model/profile_model.dart';
import 'package:dio/dio.dart';

class RegisterRepo {
  static Future<CreateAccountModel?> registerUserAccount(
      CreateAccountModel createAccountModel) async {
    return await ApiCaller.instance.requestPost(
      REGISTER,
      (data) {
        return CreateAccountModel.fromMap(data);
      },
      body: createAccountModel.toMap(),
    );
  }

  static Future<ProfileModel?> verificationUserAccount({
    required String email,
    required String code,
    required String password,
  }) async {
    ProfileModel registerModel;
    Response response = await ApiRequest.postData(
      url: VERIFY,
      body: {
        'email': email,
        'code': code,
        'password': password,
      },
      token: null,
    );
    if (response.statusCode == 200 || response.data['msg'] == 200) {
      registerModel = ProfileModel.fromJson(response.data);
      return registerModel;
    } else {
      return null;
    }
  }
}
