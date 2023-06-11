import 'dart:io';

import 'package:business/core/network/end_points.dart';
import 'package:business/core/network/remote/api_caller.dart';
import 'package:business/post/model/post_model.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

class AddPostToGroupRepo {
  static Future addPostToGroup({
    required String? token,
    required String body,
    required groupId,
    required List<File> images,
  }) async {
    List<MultipartFile> list = [];
    for (int i = 0; i < images.length; i++) {
      list.add(
        await MultipartFile.fromFile(
          images[i].path,
          filename: basename(images[i].path),
        ),
      );
    }
    return await ApiCaller.instance.requestPost(
      Add_Post_Group,
      (data) {
        return PostModel.fromJson(data["post"]);
      },
      token: token,
      body: <String, dynamic>{
        "token": token,
        "body": body,
        "group_id": groupId,
        "images[]": list,
      },
    );
  }
}
