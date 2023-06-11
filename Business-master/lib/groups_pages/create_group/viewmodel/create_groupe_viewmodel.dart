import 'dart:io';

import 'package:business/core/network/local/cache_helper.dart';
import 'package:business/groups_pages/choose_group/model/all_group_pages_data_model.dart';
import 'package:business/groups_pages/choose_group/viewmodel/choose_groupe_viewmodel.dart';
import 'package:business/groups_pages/choose_group/viewmodel/choose_pages_viewmodel.dart';
import 'package:business/groups_pages/create_group/model/create_group_model.dart';
import 'package:business/groups_pages/create_group/repo/create_group_repo.dart';
import 'package:business/groups_pages/create_group/utils/constance.dart';
import 'package:business/helper/constanc.dart';
import 'package:business/helper/functions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart' as getx;
import 'package:image_picker/image_picker.dart';

final privacyChangeDropdownValueProvider =
    StateProvider<String>((ref) => textPublic);
final categoryChangeDropdownValueProvider =
    StateProvider<String>((ref) => 'اجتماعي');

final createGroupViewModel = ChangeNotifierProvider.family.autoDispose(
  (ref, bool isPage) => CreateGroupViewModel(
    groupViewModel: ref.watch(chooseGroupViewModel),
    pagesViewModel: ref.watch(choosePagesViewModel),
    isPage: isPage,
  ),
);

class CreateGroupViewModel extends ChangeNotifier {
  /// Constructor
  CreateGroupViewModel({
    required this.groupViewModel,
    required this.pagesViewModel,
    required this.isPage,
  }) {
    myToken = CacheHelper.getStringData(key: "myToken");
  }

  ChooseGroupViewModel? groupViewModel;
  ChoosePagesViewModel? pagesViewModel;
  bool isLoading = false;
  bool isPage = false;
  String? myToken;
  File? coverImage;
  File? profileImage;
  String? coverImageFileName;
  String? profileImageFileName;
  String? categoryValue;

  /// Variable
  ///
  /// Dummy
  // TextEditingController nameController =
  //     TextEditingController(text: 'Group name');
  // TextEditingController descriptionController =
  //     TextEditingController(text: 'Group description ');
  // TextEditingController rulesController =
  //     TextEditingController(text: 'Group Rules');

  /// Real
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController rulesController = TextEditingController();

  /// Send request to join the group
  Future createGroup(String privacyValue) async {
    isLoading = true;
    notifyListeners();
    if (profileImage == null) {
      showToast(msg: 'يجب اضافة صورة');
    } else if (coverImage == null) {
      showToast(msg: 'يجب اضافة صورة الغلاف');
    } else {
      try {
        CreateGroupModel createGroupModel = CreateGroupModel.fromMap({
          'name': nameController.text,
          'token': myToken,
          'description': descriptionController.text,
          'rules': rulesController.text,
          'privacy': getPrivacyValue(privacyValue),
          'category_id': "1",
          'publisher_id': '',
          'profile_image': await MultipartFile.fromFile(
            profileImage!.path,
            filename: profileImageFileName,
          ),
          'cover_image': await MultipartFile.fromFile(
            coverImage!.path,
            filename: coverImageFileName,
          ),
        });

        GroupsPagesDataModel? groupsDataModel =
            await CreateGroupPageRepo.createGroupPage(
          createGroupModel: createGroupModel,
          isPage: isPage,
        );

        isPage
            ? pagesViewModel!.setNewGroups(groupsDataModel!)
            : groupViewModel!.setNewGroups(groupsDataModel!);
        getx.Get.back();
      } catch (e) {
        print(e.toString());
      }
    }
    isLoading = false;
    notifyListeners();
  }

  Future getImageFromGallery(String type) async {
    final ImagePicker _picker = ImagePicker();
    final pickedFIle = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFIle != null) {
      if (type == "profile") {
        profileImage = File(pickedFIle.path);
        profileImageFileName = profileImage!.path.split('/').last;
      } else {
        coverImage = File(pickedFIle.path);
        coverImageFileName = coverImage!.path.split('/').last;
      }
      print("Image selected");
      notifyListeners();
    } else {
      showToast(msg: 'No Image selected');
      print("No Image selected");
    }
  }

  String? getPrivacyValue(String privacy) {
    print(privacy);
    if (privacy == textPublic) {
      return publicValue;
    } else if (privacy == textPrivate) {
      return privateValue;
      // } else if (privacy == textSecret) {
      //   return secretValue;
    } else {
      showToast(msg: errorTextPrivacyNull, color: colorBgToastError);
    }
    return null;
  }
}
