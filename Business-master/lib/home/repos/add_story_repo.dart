import 'package:business/core/network/end_points.dart';
import 'package:business/core/network/local/cache_helper.dart';
import 'package:business/core/network/remote/api_caller.dart';
import 'package:dio/dio.dart';

class AddStoryRepo {
  static Future<bool> addStory({MultipartFile? image, String? body}) async {
    return await ApiCaller.instance.requestPost<bool>(
          addStoryPath,
          (data) {
            return true;
          },
          body: <String, dynamic>{
            "body": body,
            "media[]": image,
            "token": CacheHelper.getStringData(key: "myToken"),
            "lang": "ar",
            "privacy_id": 1,
          },
          token: CacheHelper.getStringData(key: "myToken"),
        ) ??
        false;
  }
}
