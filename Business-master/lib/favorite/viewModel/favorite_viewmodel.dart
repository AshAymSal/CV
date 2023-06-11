import 'package:business/core/network/local/cache_helper.dart';
import 'package:business/favorite/model/favorite_model.dart';
import 'package:business/favorite/repos/favorite_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteViewModel = ChangeNotifierProvider((ref) => FavoriteViewModel());

class FavoriteViewModel extends ChangeNotifier {
  FavoriteViewModel() {
    myToken = CacheHelper.getStringData(key: "myToken");
    getAllFavorite();
  }

  bool isLoading = false;
  String? myToken;
  List<FavoriteModel>? favoriteModelList = [];

  /// Get ALL Groups

  void getAllFavorite() async {
    try {
      isLoading = true;
      notifyListeners();
      favoriteModelList = await FavoriteRepo.getFavorite(token: myToken!);
      notifyListeners();
    } catch (e) {
      print(e);
      isLoading = false;
      notifyListeners();
    }
  }
}
