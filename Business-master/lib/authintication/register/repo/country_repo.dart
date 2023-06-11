import 'package:business/authintication/register/model/country_city_model.dart';
import 'package:business/core/network/end_points.dart';
import 'package:business/core/network/remote/api_caller.dart';

class CountryRepo {
  static Future<List<CountryCityModel>?> getCountry() async {
    return await ApiCaller.instance.requestGet<List<CountryCityModel>?>(
      getAllCountryPath,
      builder: (data) {
        return List<CountryCityModel>.from(
          data["countries"].map(
            (e) => CountryCityModel.fromJson(e),
          ),
        );
      },
    );
  }

  static Future<List<CountryCityModel>?> getCities({
    required int countryId,
  }) async {
    return await ApiCaller.instance.requestGet(
      getAllCitiesPath + "/$countryId",
      builder: (data) {
        return List<CountryCityModel>.from(
            data["cities"].map((e) => CountryCityModel.fromJson(e)));
      },
    );
  }
}
