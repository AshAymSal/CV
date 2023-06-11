import 'dart:async';

import 'package:business/core/network/local/cache_helper.dart';
import 'package:business/helper/functions.dart';
import 'package:business/media/model/music_model.dart';
import 'package:business/media/repos/music_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final musicViewModel = ChangeNotifierProvider.autoDispose(
  (ref) => MusicViewModel(),
);

class MusicViewModel extends ChangeNotifier {
  MusicViewModel() {
    myToken = CacheHelper.getStringData(key: "myToken");
    getAllMusic();
  }

  String? myToken;
  bool isLoading = false;

  List<MusicModel>? musicModel = [];

  Future getAllMusic() async {
    isLoading = true;
    notifyListeners();
    try {
      musicModel = await MusicRepo.getMusic(
        token: myToken!,
      );
      print(musicModel!.length);
    } catch (e) {
      print(e);
    }

    isLoading = false;
    notifyListeners();
  }

  Future deleteMusic(int id, int index) async {
    try {
      await MusicRepo.deleteMusic(
        token: myToken!,
        id: id,
      );
      showToast(msg: "تم الحذف بنجاح");
      musicModel!.removeAt(index);
    } catch (e) {
      print(e);
    }

    isLoading = false;
    notifyListeners();
  }
}
