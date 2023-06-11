import 'package:business/core/network/local/cache_helper.dart';
import 'package:business/helper/constanc.dart';
import 'package:business/helper/functions.dart';
import 'package:business/home/viewmodel/home_viewmodel.dart';
import 'package:business/view/add_post/repos/add_services_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

final addPostViewModel =
    ChangeNotifierProvider.autoDispose((ref) => AddPostViewModel(ref));

class AddPostViewModel extends ChangeNotifier {
  AddPostViewModel(this.ref) {
    myToken = CacheHelper.getStringData(key: "myToken");
  }
  ProviderReference ref;

  TextEditingController titleController = TextEditingController();

  String? myToken;

  List<XFile> imageFiles = [];
  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();

  pickedFilesImages() async {
    try {
      final pickedFileList = await (_picker.pickMultiImage());
      imageFiles..addAll(pickedFileList!);
      print(imageFiles);
      notifyListeners();
    } catch (e) {
      print(e.toString());
      notifyListeners();
    }
  }

  deleteSelectedImage(XFile index) {
    imageFiles.remove(index);
    notifyListeners();
  }

  Future addPost() async {
    isLoading = true;
    notifyListeners();

    List<MultipartFile> list = [];
    for (int i = 0; i < imageFiles.length; i++) {
      list.add(
        await MultipartFile.fromFile(
          imageFiles[0].path,
          filename: basename(imageFiles[0].path),
        ),
      );
    }
    try {
      await AddPostsRepo.addPost(
        token: myToken,
        title: titleController.text,
        files: list,
      );
      ref.read(homeViewModel).gePostsData();
    } catch (e) {
      showToast(msg: e.toString(), color: colorBgToastError);
      print(e.toString());
    }
    isLoading = false;
    notifyListeners();
  }
}
