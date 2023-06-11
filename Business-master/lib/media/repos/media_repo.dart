import 'package:business/core/network/remote/api_caller.dart';
import 'package:business/media/model/media_model.dart';

class MediaRepo {
  static Future<List<MediaModel>?> getPhoto({
    required String token,
    required int groupId,
    required String path,
  }) async {
    return (await ApiCaller.instance.requestPost(
          path,
          (data) {
            return List<MediaModel>.from(data['image'].map(
              (image) => MediaModel.fromJson(image),
            ));
          },
          token: token,
          body: <String, dynamic>{
            "token": token,
            "group_id": groupId,
            "media_type": "image",
          },
        )) ??
        [];
  }
}
