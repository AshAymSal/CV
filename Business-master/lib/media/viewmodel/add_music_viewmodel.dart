import 'dart:io';

import 'package:business/core/network/local/cache_helper.dart';
import 'package:business/helper/constanc.dart';
import 'package:business/helper/functions.dart';
import 'package:business/media/repos/music_repo.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

final addMusicViewModel =
    ChangeNotifierProvider.autoDispose((ref) => AddMusicViewModel());

class AddMusicViewModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  File? musicCoverImage, musicFile;
  String? myToken;
  bool? isLoading = false;
  final formKey = GlobalKey<FormState>();

  AddMusicViewModel() {
    myToken = CacheHelper.getStringData(key: "myToken");
  }

  Future getImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final pickedFIle = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFIle != null) {
      musicCoverImage = File(pickedFIle.path);
      print(musicCoverImage);

      notifyListeners();
    } else {
      showToast(msg: 'لم يتم الاختيار');
      print("No Image selected");
    }
  }

  Future getMusicFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.audio);

    if (result != null) {
      File file = File(result.files.single.path!);
      musicFile = File(file.path);
      print(musicFile);
      notifyListeners();
    } else {
      showToast(msg: 'لم يتم اختيار الملف');
      print("No Image selected");
    }
  }

  Future addMusic() async {
    isLoading = true;
    notifyListeners();
    try {
      if (musicCoverImage != null && musicFile != null) {
        await MusicRepo.addMusic(
          name: nameController.text,
          token: myToken!,
          musicCover: musicCoverImage!,
          music: musicFile!,
        ).then((result) {
          if (result != null) {
            Get.back(result: true);
          }
        });
      } else {
        showToast(msg: 'لم يتم اختيار الملف');
      }
    } catch (e) {
      showToast(msg: e.toString(), color: colorBgToastError);
      print(e.toString());
    }
    isLoading = false;
    notifyListeners();
  }
}
