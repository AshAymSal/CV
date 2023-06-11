import 'package:business/core/network/end_points.dart';
import 'package:business/core/network/remote/api_caller.dart';
import 'package:business/post/model/post_model.dart';

class PostsRepo {
  static Future<List<PostModel>?> getAllPosts({
    required String? token,
    required int? modelId,
    required String? modelType,
  }) async {
    return await ApiCaller.instance.requestPost(
      getAllPostsPath,
      (data) {
        return List<PostModel>.from(data.map(
          (post) => PostModel.fromJson(post),
        ));
      },
      token: token,
      body: <String, dynamic>{
        "token": token,
        "model_type": modelType,
        "model_id": modelId,
      },
    );
  }

  static Future addLike({
    String? token,
    postId,
    modelType,
    int? reactId,
  }) async {
    print("pesa");
    print({
      "token": token,
      "model_id": postId,
      "model_type": modelType,
      "reactId": reactId,
    });
    return await ApiCaller.instance.requestPost(
      Add_Update_Delete_Post_Likes,
      (data) {
        if (data['like'] != null) {
          return data['like']['reactId'];
        } else {
          return null;
        }
      },
      token: token,
      body: <String, dynamic>{
        "token": token,
        "model_id": postId,
        "model_type": modelType,
        "reactId": reactId,
      },
    );
  }

  static Future sharePost({
    String? token,
    postId,
    body,
  }) async {
    return await ApiCaller.instance.requestPost(
      sharePostPath,
      (data) {
        return null;
      },
      token: token,
      body: {
        "token": token,
        "body": body,
        "post_id": postId,
      },
    );
  }
}
