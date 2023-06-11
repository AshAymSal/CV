import 'package:business/core/network/end_points.dart';
import 'package:business/core/network/remote/api_caller.dart';
import 'package:business/post/model/like_post_model.dart';
import 'package:business/post/model/share_post_model.dart';

class ShareLikePostRepo {
  static Future<SharePostModel?> getSharePost({
    String? token,
    groupId,
    postId,
  }) async {
    return await ApiCaller.instance.requestPost(
      Get_Post_SHARES,
      (data) {
        return SharePostModel.fromJson(data);
      },
      token: token,
      body: {
        "token": token,
        "group_id": groupId,
        "post_id": postId,
      },
    );
  }

  static Future<LikePostModel?> getLikesPost({
    String? token,
    postId,
    modelType,
  }) async {
    return await ApiCaller.instance.requestPost(
      Get_Post_Likes,
      (data) {
        return LikePostModel.fromJson(data);
      },
      token: token,
      body: {
        "token": token,
        "model_id": postId,
        "model_type": modelType,
      },
    );
  }
}
