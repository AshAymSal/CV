import 'package:business/company_delivery/repos/company_repo.dart';
import 'package:business/core/network/local/cache_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'model/company_model.dart';

final companyDeliveryViewModel =
    ChangeNotifierProvider.autoDispose((ref) => CompanyDeliveryViewModel());

class CompanyDeliveryViewModel extends ChangeNotifier {
  CompanyDeliveryViewModel() {
    myToken = CacheHelper.getStringData(key: "myToken");
    getAllCompanies();
  }

  bool isLoading = false;
  List<CompanyModel>? companiesModelList = [];

  String? myToken;

  void getAllCompanies() async {
    isLoading = true;
    notifyListeners();
    try {
      companiesModelList = await CompanyRepo.getAllCompany(token: myToken!);
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }

  makingPhoneCall(value) async {
    var url = 'tel:$value';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void changeIsExpanded(int panelIndex, bool isExpanded) {
    companiesModelList![panelIndex].isExpanded = !isExpanded;
    notifyListeners();
  }
}
