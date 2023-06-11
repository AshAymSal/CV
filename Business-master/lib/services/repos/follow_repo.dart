import 'package:business/core/network/end_points.dart';
import 'package:business/core/network/remote/api_caller.dart';

class FollowRepo {
  static Future addFollow(
      {required String token, required int followingId}) async {
    return await ApiCaller.instance.requestPost(
          addFollowPath,
          (data) {},
          body: <String, dynamic>{"token": token, "followingId": followingId}
              .cast(),
          token: token,
        ) ??
        [];
  }

  static Future unFollow(
      {required String token, required int followingId}) async {
    print(token);
    print(followingId);
    print("pesa");
    return await ApiCaller.instance.requestPost(
          unFollowPath,
          (data) {},
          body: <String, dynamic>{
            "token": token,
            "followingId": followingId,
          }.cast(),
          token: token,
        ) ??
        [];
  }
}
