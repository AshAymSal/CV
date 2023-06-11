import 'package:business/core/network/end_points.dart';
import 'package:business/core/network/remote/api_caller.dart';
import 'package:business/profile/model/edit_profile_model.dart';
import 'package:dio/dio.dart';

class EditProfileRepo {
  static Future<bool> updateAccount(
      EditProfileModel editProfileModel, String token) async {
    print(editProfileModel.toMap());
    return await ApiCaller.instance.requestPost<bool>(
          profileEditPath,
          (data) {
            return true;
          },
          body: editProfileModel.toMap(),
          token: token,
        ) ??
        false;
  }

  static uploadImage({
    required String token,
    required String type,
    required MultipartFile image,
  }) async {
    print(type + " " + image.toString());
    return await ApiCaller.instance.requestPost(
      uploadImagePath,
      (data) {
        if (data != null) {
          return true;
        }
      },
      token: token,
      body: <String, dynamic>{
        "token": token,
        "type": type,
        "image": image,
      },
    );
  }
}
