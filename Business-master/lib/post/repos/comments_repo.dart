import 'package:business/core/network/end_points.dart';
import 'package:business/core/network/remote/api_caller.dart';
import 'package:business/helper/constanc.dart';
import 'package:business/helper/functions.dart';
import 'package:business/model/comments_data_model.dart';

class CommentsRepo {
  static Future<List<CommentsModel>?> getPostComments({
    String? token,
    modelId,
    modelType,
  }) async {
    print(modelId);
    print(modelType);
    return await ApiCaller.instance.requestPost(
      Get_Post_Comments,
      (data) {
        return List<CommentsModel>.from(
          data['comments'].map((comment) => CommentsModel.fromJson(comment)),
        );
      },
      token: token,
      body: <String, dynamic>{
        "token": token,
        "model_id": modelId,
        "model_type": modelType,
      },
    );
  }

  static Future<CommentsModel?> addComments({
    String? token,
    modelId,
    modelType,
    body,
  }) async {
    return await ApiCaller.instance.requestPost(
      ADD_CommentsPath,
      (data) {
        return CommentsModel.fromJson(data["comment"]);
      },
      token: token,
      body: <String, dynamic>{
        "token": token,
        "model_id": modelId,
        "model_type": modelType,
        "body": body,
      },
    );
  }

  static Future editComments({
    String? token,
    commentId,
    modelType,
    body,
  }) async {
    return await ApiCaller.instance.requestPost(
      Edit_CommentsPath,
      (data) {
        if (data["message"] == "your comment has been updated successfully") {
          return true;
        } else {
          return false;
        }
      },
      token: token,
      body: <String, dynamic>{
        "token": token,
        "comment_id": commentId,
        "body": body,
      },
    );
  }

  static Future deleteComments({
    String? token,
    commentId,
    modelType,
  }) async {
    return await ApiCaller.instance.requestPost(
      deleteCommentsPath,
      (data) {
        if (data["message"] == "your comment has been deleted successfully") {
          showToast(
            msg: 'your comment has been deleted successfully',
            color: colorBgToastSuccessBg,
          );
          return true;
        } else {
          return false;
        }
      },
      token: token,
      body: <String, dynamic>{
        "token": token,
        "comment_id": commentId,
      },
    );
  }

  static Future reportComments({
    String? token,
    commentId,
    modelType,
    body,
  }) async {
    print(body);
    return await ApiCaller.instance.requestPost(
      reportCommentsPath,
      (data) {
        if (data["message"] == "Your report has sent  successfully") {
          showToast(
            msg: 'Your report has sent  successfully',
            color: colorBgToastSuccessBg,
          );
          return true;
        } else {
          return false;
        }
      },
      token: token,
      body: <String, dynamic>{
        "token": token,
        "model_id": commentId,
        "body": body,
        "model_type": modelType,
      },
    );
  }
}
