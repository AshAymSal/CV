import 'package:business/core/network/end_points.dart';
import 'package:business/core/network/remote/api_caller.dart';
import 'package:dio/dio.dart';

class AddPostsRepo {
  static Future addPost({
    required String title,
    required List<MultipartFile> files,
    String? token,
  }) async {
    return await ApiCaller.instance.requestPost(
      Add_Post_Group,
      (data) {
        print(data);
      },
      token: token,
      body: {
        'token': token,
        'body': title,
        'media[]': files,
        'privacy_id': 1,
        'category_id': 1,
      },
    );
  }
}
