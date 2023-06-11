import 'package:business/core/network/local/cache_helper.dart';
import 'package:business/services/models/all_services_model.dart';
import 'package:business/services/repos/get_all_services_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final servicesViewModel = ChangeNotifierProvider.autoDispose
    .family((ref, String? categoryId) => ServicesViewModel(categoryId!));

class ServicesViewModel extends ChangeNotifier {
  ServicesViewModel(this.categoryId) {
    myToken = CacheHelper.getStringData(key: "myToken") ?? '';
    getServiceProducts(categoryId: this.categoryId);
  }

  bool isLoading = false;
  late String myToken;
  late String categoryId;
  List<ServicesModel>? servicesDataList = [];

  Future getServiceProducts({required String? categoryId}) async {
    isLoading = true;
    notifyListeners();
    servicesDataList = await GetAllServicesRepo.getAllServicesByCategory(
      token: myToken,
      categoryId: categoryId ?? '',
    );
    isLoading = false;
    notifyListeners();
  }
}
