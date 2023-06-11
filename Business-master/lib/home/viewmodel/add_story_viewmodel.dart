import 'dart:io';

import 'package:business/helper/functions.dart';
import 'package:business/home/repos/add_story_repo.dart';
import 'package:dio/dio.dart' as dios;
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'home_viewmodel.dart';

final addStoryViewModel =
    ChangeNotifierProvider((ref) => AddStoryViewModel(ref));

class AddStoryViewModel extends ChangeNotifier {
  AddStoryViewModel(this.ref);

  bool isLoading = false;
  File? profileImage;
  String? profileImageFileName;
  TextEditingController? storyBodyController = TextEditingController();

  final ProviderReference ref;

  Future getImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final pickedFIle = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFIle != null) {
      profileImage = File(pickedFIle.path);
      profileImageFileName = profileImage!.path.split('/').last;
      notifyListeners();
    } else {
      showToast(msg: 'No Image selected');
      print("No Image selected");
    }
  }

  Future addStory() async {
    isLoading = true;
    notifyListeners();
    try {
      var result = await AddStoryRepo.addStory(
        body: storyBodyController!.text,
        image: await dios.MultipartFile.fromFile(
          profileImage!.path,
          filename: profileImageFileName,
        ),
      );
      if (result is bool && result == true) {
        isLoading = false;
        notifyListeners();
        Get.back(result: true);
        ref.read(homeViewModel).getStoriesData();
      } else {
        isLoading = false;
        notifyListeners();
        showToast(msg: 'حدث مشكلة');
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      showToast(msg: 'حدث مشكلة');
      print(e);
    }
  }
}
