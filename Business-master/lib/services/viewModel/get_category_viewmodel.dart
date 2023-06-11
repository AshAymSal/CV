import 'package:business/core/network/local/cache_helper.dart';
import 'package:business/services/models/category_model.dart';
import 'package:business/services/repos/get_category_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getCategoryViewModel =
    ChangeNotifierProvider((ref) => GetCategoryViewModel());

class GetCategoryViewModel extends ChangeNotifier {
  GetCategoryViewModel() {
    myToken = CacheHelper.getStringData(key: "myToken");

    getAllCategories();
  }

  bool isLoading = false;
  List<CategoriesModel>? categoriesModelList = [];
  CategoriesModel? selectedCategoryModel;

  List<String?> nameOfCategoryList = [];

  String? myToken;

  void getAllCategories() async {
    isLoading = true;
    notifyListeners();

    try {
      categoriesModelList = await GetCategoryRepo.getCategory(token: myToken!);

      categoriesModelList!.forEach((element) {
        nameOfCategoryList.add(element.name);
      });
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }

  void changeCategory(CategoriesModel? value) {
    selectedCategoryModel = value;
    notifyListeners();
  }
}
