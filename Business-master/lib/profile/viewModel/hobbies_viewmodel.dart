import 'dart:async';

import 'package:business/core/network/local/cache_helper.dart';
import 'package:business/helper/functions.dart';
import 'package:business/profile/model/hobbies_model.dart';
import 'package:business/profile/model/my_hobbies_model.dart';
import 'package:business/profile/repo/hobbies_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final hobbiesViewModel = ChangeNotifierProvider.autoDispose(
  (ref) => HobbiesViewModel(),
);

class HobbiesViewModel extends ChangeNotifier {
  HobbiesViewModel() {
    myToken = CacheHelper.getStringData(key: "myToken");
    getAllSports();
    getMySports();
  }

  String? myToken;
  bool isLoading = false;
  bool addSportsIsLoading = false;
  bool removeSportsIsLoading = false;

  List<HobbiesModel>? allHobbiesModelList = [];
  List<MyHobbiesModel>? myHobbiesModelList = [];

  int buttonSelected = 0;

  chooseButton(int index) {
    buttonSelected = index;
    notifyListeners();
  }

  Future getAllSports() async {
    isLoading = true;
    notifyListeners();
    try {
      allHobbiesModelList = await HobbiesRepo.getAllHobbies(
        token: myToken!,
      );
    } catch (e) {
      print(e);
    }

    isLoading = false;
    notifyListeners();
  }

  Future getMySports() async {
    isLoading = true;
    notifyListeners();
    try {
      myHobbiesModelList = await HobbiesRepo.getMyHobbies(
        token: myToken!,
      );
    } catch (e) {
      print(e);
    }

    isLoading = false;
    notifyListeners();
  }

  Future addHobbies({required HobbiesModel hobbiesModel}) async {
    addSportsIsLoading = true;
    notifyListeners();
    try {
      var result = await HobbiesRepo.addHobbies(
        token: myToken!,
        targetId: hobbiesModel.id!,
      );
      if (result is bool && result == true) {
        myHobbiesModelList!.add(MyHobbiesModel(hobby: hobbiesModel));
        allHobbiesModelList!
            .removeWhere((element) => element.id == hobbiesModel.id);
        getMySports();// Mina Fixing removing without refresh 7/1/2022
      } else {
        showToast(msg: 'حدثت مشكلة');
      }
    } catch (e) {
      print(e);
    }
    addSportsIsLoading = false;
    notifyListeners();
  }

  Future removeHobbies({required MyHobbiesModel model}) async {
    removeSportsIsLoading = true;
    notifyListeners();
    try {
      var result = await HobbiesRepo.removeHobbies(
        token: myToken!,
        targetId: model.id!,
      );
      if (result is bool && result == true) {

        myHobbiesModelList! //Mina Removing hobbies 5/1/2022
            .removeWhere((element) => element.id == model.id);

/*        myHobbiesModelList!
            .removeWhere((element) => element.hobby!.id! == model.id);*/
        allHobbiesModelList!.add(model.hobby!);
      } else {
        showToast(msg: 'حدثت مشكلة');
      }
    } catch (e) {
      print(e);
    }
    removeSportsIsLoading = false;
    notifyListeners();
  }
}
