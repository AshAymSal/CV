import 'package:business/core/network/end_points.dart';
import 'package:business/core/network/remote/api_caller.dart';
import 'package:business/services/models/all_services_model.dart';

class GetAllServicesRepo {
  static Future<List<ServicesModel>> getAllServicesByCategory({
    required String token,
    String? categoryId,
    String? searchText,
  }) async {
    return await ApiCaller.instance.requestPost<List<ServicesModel>>(
          getAllServicesPath,
          (data) {
            return List<ServicesModel>.from(
              data['services'].map(
                (model) => ServicesModel.fromJson(model),
              ),
            );
          },
          body: <String, dynamic>{
            "lang": "ar",
            "category_id": categoryId,
            "search": searchText,
          },
          token: token,
        ) ??
        [];
  }
}
