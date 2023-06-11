import 'package:business/core/network/end_points.dart';
import 'package:business/core/network/remote/api_caller.dart';
import 'package:business/services/models/category_model.dart';

class GetCategoryRepo {
  static Future<List<CategoriesModel>> getCategory(
      {required String token}) async {
    return await ApiCaller.instance.requestPost<List<CategoriesModel>>(
          getCategoriesPath,
          (data) {
            return List<CategoriesModel>.from(
              data['categories'].map(
                (model) => CategoriesModel.fromJson(model),
              ),
            );
          },
          body: {"lang": "ar"}.cast(),
          token: token,
        ) ??
        [];
  }
}
