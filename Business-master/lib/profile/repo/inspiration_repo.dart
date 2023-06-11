import 'package:business/core/network/end_points.dart';
import 'package:business/core/network/remote/api_caller.dart';
import 'package:business/profile/model/inspiration_model.dart';

class InspirationRepo {
  static Future<List<InspirationModel>?> getAllInspiration({
    required String token,
  }) async {
    print(token);
    return (await ApiCaller.instance.requestPost(
          getAllInspirationsPath,
          (data) {
            return List<InspirationModel>.from(
              data["myInspiration"].map(
                (model) => InspirationModel.fromMap(model),
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

  static Future<bool> removeInspiration({
    required String token,
    required String targetId,
  }) async {
    return (await ApiCaller.instance.requestPost<bool>(
          removeInspirationsPath,
          (data) {
            if (data != null) {
              return true;
            }
            return false;
          },
          token: token,
          body: <String, dynamic>{
            "token": token,
            "inspirerende_id": targetId,
          },
        )) ??
        false;
  }
}
