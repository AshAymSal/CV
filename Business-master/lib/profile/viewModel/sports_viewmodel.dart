import 'dart:async';

import 'package:business/core/network/local/cache_helper.dart';
import 'package:business/helper/functions.dart';
import 'package:business/profile/model/my_sports_model.dart';
import 'package:business/profile/model/sports_model.dart';
import 'package:business/profile/repo/sprots_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sportsViewModel = ChangeNotifierProvider.autoDispose(
  (ref) => SportsViewModel(),
);

class SportsViewModel extends ChangeNotifier {
  SportsViewModel() {
    myToken = CacheHelper.getStringData(key: "myToken");
    getAllSports();
    getMySports();
  }

  String? myToken;
  bool isLoading = false;
  bool addSportsIsLoading = false;
  bool removeSportsIsLoading = false;

  List<SportsModel>? allSportsModelList = [];
  List<MySportsModel>? mySportsModelList = [];

  int buttonSelected = 0;

  chooseButton(int index) {
    buttonSelected = index;
    notifyListeners();
  }

  Future getAllSports() async {
    isLoading = true;
    notifyListeners();
    try {
      allSportsModelList = await SportsRepo.getAllSports(
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
    // try {
    mySportsModelList = await SportsRepo.getMySports(
      token: myToken!,
    );
    // } catch (e) {
    //   print(e);
    // }

    isLoading = false;
    notifyListeners();
  }

  Future addSports({required SportsModel sportsModel}) async {
    addSportsIsLoading = true;
    notifyListeners();
    try {
      var result = await SportsRepo.addSports(
        token: myToken!,
        targetId: sportsModel.id!,
      );
      if (result is bool && result == true) {
        allSportsModelList!
            .removeWhere((element) => element.id == sportsModel.id);
        mySportsModelList!.add(MySportsModel(sport: sportsModel));
        getMySports();//Mina 10/1/2022
      } else {
        showToast(msg: 'حدثت مشكلة');
      }
    } catch (e) {
      print(e);
    }
    addSportsIsLoading = false;
    notifyListeners();
  }

  Future removeSports({required MySportsModel sportsModel}) async { //Mina 10/1/2022 Fixing the Model
    removeSportsIsLoading = true;
    notifyListeners();
    try {
      var result = await SportsRepo.removeSports(
        token: myToken!,
        targetId: sportsModel.id!,
      );
      if (result is bool && result == true) {
        mySportsModelList!
            .removeWhere((element) => element.id! == sportsModel.id!);
        allSportsModelList!.add(sportsModel.sport!);
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
