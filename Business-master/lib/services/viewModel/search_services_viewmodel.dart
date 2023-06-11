import 'package:business/core/network/local/cache_helper.dart';
import 'package:business/services/models/all_services_model.dart';
import 'package:business/services/repos/get_all_services_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchServicesViewModel =
    ChangeNotifierProvider((ref) => SearchServicesViewModel());

class SearchServicesViewModel extends ChangeNotifier {
  bool isLoading = false;

  List<ServicesModel>? searchServicesModel = [];

  SearchServicesViewModel() {
    myToken = CacheHelper.getStringData(key: "myToken") ?? '';
  }

  late String myToken;

  Future getSearchServiceProducts({required searchText}) async {
    isLoading = true;
    notifyListeners();
    searchServicesModel = await GetAllServicesRepo.getAllServicesByCategory(
      token: myToken,
      searchText: searchText,
    );
    isLoading = false;
    notifyListeners();
  }
}
