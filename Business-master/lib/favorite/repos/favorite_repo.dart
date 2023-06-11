import 'package:business/core/network/end_points.dart';
import 'package:business/core/network/remote/api_caller.dart';
import 'package:business/favorite/model/favorite_model.dart';

class FavoriteRepo {
  static Future<List<FavoriteModel>?> getFavorite({
    required String token,
  }) async {
    return (await ApiCaller.instance.requestPost(
          getAllFavoritePath,
          (data) {
            return [];
            // return List<MediaModel>.from(data['image'].map(
            //   (image) => MediaModel.fromJson(image),
            // ));
          },
          token: token,
          body: <String, dynamic>{
            "token": token,
          },
        )) ??
        [];
  }
}
