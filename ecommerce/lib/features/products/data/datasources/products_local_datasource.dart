
import 'package:dartz/dartz.dart';
import 'package:ecommernce/features/products/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductsLocalDataSource {
  Future<List<ProductModel>> getCachedFavorites();
  Future<List<ProductModel>> getCachedSales();
  Future<Unit> cacheFavorites(List<ProductModel> productModels);
}

const CACHED_FAVORITES = "CACHED_FAVORITES";
const CACHED_SALES = "CACHED_SALES";

class ProductsLocalDataSourceImpl implements ProductsLocalDataSource {
  @override
  Future<Unit> cacheFavorites(List<ProductModel> productModels) {
    // TODO: implement cacheFavorites
    print("asD");
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getCachedFavorites() {
    // TODO: implement getCachedFavorites
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getCachedSales() {
    // TODO: implement getCachedFavorites
    throw UnimplementedError();
  }
  // SharedPreferences sharedPreferences;

  //ProductsLocalDataSourceImpl({required this.sharedPreferences});
  /* @override
  Future<Unit> cacheFavorites(List<ProductModel> postModels) {
    List postModelsToJson = postModels
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    sharedPreferences.setString(
        CACHED_FAVORITES, json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<ProductModel>> getCachedFavorites() {
    final jsonString = sharedPreferences.getString(CACHED_FAVORITES);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<ProductModel> jsonToPostModels = decodeJsonData
          .map<ProductModel>(
              (jsonPostModel) => ProductModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCacheException();
    }
  }*/
}
