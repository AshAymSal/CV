import 'package:business/core/network/end_points.dart';
import 'package:business/core/network/remote/api_caller.dart';
import 'package:business/profile/model/hobbies_model.dart';
import 'package:business/profile/model/my_hobbies_model.dart';

class HobbiesRepo {
  static Future<List<HobbiesModel>?> getAllHobbies({
    required String token,
  }) async {
    return (await ApiCaller.instance.requestPost(
          allHobbiesPath,
          (data) {
            return List<HobbiesModel>.from(
              data["allHoppies"].map(
                (model) => HobbiesModel.fromMap(model),
              ),
            );
          },
          token: token,
          body: <String, dynamic>{
            "token": token,
          },
        )) ??
        [];
  }

  static Future<List<MyHobbiesModel>?> getMyHobbies({
    required String token,
  }) async {
    return (await ApiCaller.instance.requestPost(
          myHobbiesPath,
          (data) {
            return List<MyHobbiesModel>.from(
              data["myHoppies"].map(
                (model) => MyHobbiesModel.fromJson(model),
              ),
            );
          },
          token: token,
          body: <String, dynamic>{
            "token": token,
          },
        )) ??
        [];
  }

  static Future<bool> addHobbies({
    required String token,
    required int targetId,
  }) async {
    return (await ApiCaller.instance.requestPost<bool>(
          addHobbiesPath,
          (data) {
            if (data != null) {
              return true;
            }
            return false;
          },
          token: token,
          body: <String, dynamic>{
            "token": token,
            "target_id": targetId,
          },
        )) ??
        false;
  }

  static Future<bool> removeHobbies({
    required String token,
    required int targetId,
  }) async {
    return (await ApiCaller.instance.requestPost<bool>(
          removeHobbiesPath,
          (data) {
            if (data != null) {
              return true;
            }
            return false;
          },
          token: token,
          body: <String, dynamic>{
            "token": token,
            "target_id": targetId,
          },
        )) ??
        false;
  }
}
