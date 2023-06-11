import 'package:business/company_delivery/model/company_model.dart';
import 'package:business/core/network/end_points.dart';
import 'package:business/core/network/remote/api_caller.dart';

class CompanyRepo {
  static Future<List<CompanyModel>?> getAllCompany({
    required String token,
  }) async {
    print(token);
    return (await ApiCaller.instance.requestPost<List<CompanyModel>?>(
          getAllCompanyPath,
          (data) {
            return List<CompanyModel>.from(
              data['companies'].map(
                (model) => CompanyModel.fromJson(model),
              ),
            );
          },
          token: token,
          body: <String, dynamic>{
            "token": token,
            "lang": "ar",
          },
        )) ??
        [].cast();
  }
}
