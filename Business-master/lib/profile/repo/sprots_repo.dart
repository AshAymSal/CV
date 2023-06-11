import 'package:business/core/network/end_points.dart';
import 'package:business/core/network/remote/api_caller.dart';
import 'package:business/profile/model/my_sports_model.dart';
import 'package:business/profile/model/sports_model.dart';

class SportsRepo {
  static Future<List<SportsModel>?> getAllSports({
    required String token,
  }) async {
    return (await ApiCaller.instance.requestPost(
          allSportsPath,
          (data) {
            return List<SportsModel>.from(
              data["allSports"].map(
                (model) => SportsModel.fromMap(model),
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

  static Future<List<MySportsModel>?> getMySports({
    required String token,
  }) async {
    return (await ApiCaller.instance.requestPost(
          mySportsPath,
          (data) {
            return List<MySportsModel>.from(
              data["myHoppies"].map(
                (model) => MySportsModel.fromJson(model),
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

  static Future<bool> addSports({
    required String token,
    required int targetId,
  }) async {
    return (await ApiCaller.instance.requestPost<bool>(
          addSportsPath,
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

  static Future<bool> removeSports({
    required String token,
    required int targetId,
  }) async {
    return (await ApiCaller.instance.requestPost<bool>(
          removeSportsPath,
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
