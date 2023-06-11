import 'dart:async';

import 'package:business/core/network/local/cache_helper.dart';
import 'package:business/helper/functions.dart';
import 'package:business/profile/model/inspiration_model.dart';
import 'package:business/profile/repo/inspiration_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final inspirationViewModel = ChangeNotifierProvider.autoDispose(
  (ref) => InspirationViewModel(),
);

class InspirationViewModel extends ChangeNotifier {
  InspirationViewModel() {
    myToken = CacheHelper.getStringData(key: "myToken");
    getAllInspiration();
  }

  String? myToken;
  bool isLoading = false;
  bool isInspirationLoading = false;

  List<InspirationModel>? inspirationModel = [];

  Future getAllInspiration() async {
    isLoading = true;
    notifyListeners();
    try {
      inspirationModel = await InspirationRepo.getAllInspiration(
        token: myToken!,
      );
    } catch (e) {
      print(e);
    }

    isLoading = false;
    notifyListeners();
  }

  Future removeInspiration({required String id}) async {
    isInspirationLoading = true;
    notifyListeners();
    try {
      var result = await InspirationRepo.removeInspiration(
        token: myToken!,
        targetId: id,
      );
      if (result is bool && result == true) {
        inspirationModel!
            .removeWhere((element) => element.inspirerendeId! == id);
      } else {
        showToast(msg: 'حدثت مشكلة');
      }
    } catch (e) {
      print(e);
    }
    isInspirationLoading = false;
    notifyListeners();
  }
}
