import 'package:business/core/network/end_points.dart';
import 'package:business/core/network/remote/api_caller.dart';
import 'package:dio/dio.dart';

class AddServicesRepo {
  static Future addServices({
    required String title,
    required String body,
    required String price,
    required int categoryId,
    required int countryId,
    required int cityId,
    required List<MultipartFile> files,
    String? token,
  }) async {
    return await ApiCaller.instance.requestPost(
      addServicePath,
      (data) {
        print(data);
      },
      token: token,
      body: {
        'token': token,
        'title': title,
        'body': body,
        'price': price,
        'category_id': categoryId,
        'country_id': countryId,
        'city_id': cityId,
        'images[]': files,
      },
    );
  }
}
