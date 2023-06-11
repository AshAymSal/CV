// import 'dart:io';
//
// import 'package:business/core/network/local/cache_helper.dart';
// import 'package:business/groups_pages/group_details/repo/add_post_to_group_repo.dart';
// import 'package:business/helper/constanc.dart';
// import 'package:business/helper/functions.dart';
// import 'package:business/post/model/post_model.dart';
// import 'package:business/post/viewmodel/models_viewmodel.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// import 'groupe_details_viewmodel.dart';
//
// final addPostToGroupViewModel = ChangeNotifierProvider(
//   (ref) => AddPostToGroupViewModel(
//     groupId: ref.watch(modelPostIdProvider).state,
//     groupDetailsViewModel: ref.watch(
//       // groupDetailsViewModel(
//       //   // ref.watch(modelPostIdProvider).state!,
//       // ),
//     ),
//   ),
// );
//
// class AddPostToGroupViewModel extends ChangeNotifier {
//   /// Constructor
//   AddPostToGroupViewModel({this.groupId, this.groupDetailsViewModel}) {
//     myToken = CacheHelper.getStringData(key: "myToken");
//   }
//
//   GroupDetailsViewModel? groupDetailsViewModel;
//   bool isLoading = false;
//   int? groupId;
//   String? myToken;
//
//   TextEditingController postDescriptionController = TextEditingController();
//
//   List<XFile> imageFiles = [];
//   final ImagePicker _picker = ImagePicker();
//
//   pickedFilesImages() async {
//     try {
//       final pickedFileList = await (_picker.pickMultiImage());
//       imageFiles..addAll(pickedFileList!);
//       print(imageFiles);
//       notifyListeners();
//     } catch (e) {
//       print(e.toString());
//       notifyListeners();
//     }
//   }
//
//   deleteSelectedImage(XFile index) {
//     imageFiles.remove(index);
//     notifyListeners();
//   }
//
//   addPostToGroup() async {
//     isLoading = true;
//     notifyListeners();
//     List<File> images = [];
//     try {
//       for (int i = 0; i < imageFiles.length; i++) {
//         images..add(File(imageFiles[i].path));
//       }
//       PostModel? groupPosts = await AddPostToGroupRepo.addPostToGroup(
//         token: myToken,
//         body: postDescriptionController.text.length == 0
//             ? ''
//             : postDescriptionController.text,
//         groupId: groupId,
//         images: images,
//       );
//       if (groupPosts != null) {
//         postDescriptionController.text = '';
//         images = [];
//         imageFiles = [];
//         groupDetailsViewModel!.postsList!.add(groupPosts);
//         Get.back(result: "Done");
//       }
//       notifyListeners();
//     } catch (e) {
//       showToast(msg: e.toString(), color: colorBgToastError);
//       print(e.toString());
//     }
//     isLoading = false;
//     notifyListeners();
//   }
// }
