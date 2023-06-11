import 'package:business/chatting/model/recent_chat_model.dart';
import 'package:business/chatting/repos/chatting_details_repo.dart';
import 'package:business/chatting/screen/chatting_details/chat_message_screen.dart';
import 'package:business/core/network/local/cache_helper.dart';
import 'package:business/core/network/local/shared_preferences_service.dart';
import 'package:business/post/model/post_model.dart';
import 'package:business/profile/model/profile_model.dart';
import 'package:business/profile/repo/profile_repo.dart';
import 'package:business/services/models/all_services_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

final profileViewModel = ChangeNotifierProvider.family.autoDispose(
  (ref, int userId) =>
      ProfileViewModel(userId, ref.read(sharedPreferencesServiceProvider)),
);

class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel(this.userId, this.sharedPreferencesService) {
    myToken = CacheHelper.getStringData(key: "myToken");
    if (userId == -1) {
      userId = CacheHelper.getIntData(key: "id");
    }
    getProfileDetails();
  }

  bool isLoading = false;
  bool isLoadingChat = false;

  String? myToken;
  int? userId;

  late ProfileModel profileModel;
  List<PostModel> postsModelList = [];
  List<ServicesModel> servicesList = [];

  int buttonSelected = 1;
  final SharedPreferencesService sharedPreferencesService;

  chooseButton(int index) {
    buttonSelected = index;
    notifyListeners();
  }

  Future getProfileDetails() async {
    isLoading = true;
    notifyListeners();
    var list = await ProfileRepo.getProfileDetails(
      token: myToken!,
      id: userId!,
    );
    profileModel = list[0];
    postsModelList = list[1];
    servicesList = list[2];
    if (profileModel.myProfile! == 1) {
      await sharedPreferencesService.setUserData(profileModel);
    }
    isLoading = false;
    notifyListeners();
  }

  Future navigationToChatMessageScreen({required context}) async {
    isLoadingChat = true;
    notifyListeners();

    RecentChatModel recentChatModel = (await ChattingDetailsRepo.instance
        .checkCreatedThread(
            receiverName: profileModel.name!,
            receiverImage: profileModel.personalImage!,
            receiverId: profileModel.id!,
            clientName: sharedPreferencesService.getUserData()!.name!,
            clientImage: sharedPreferencesService.getUserData()!.personalImage!,
            clientId: sharedPreferencesService.getUserData()!.id!));

    Get.to(
      () => ChatMessageScreen(
        recentChatModel: recentChatModel,
      ),
    );

    isLoadingChat = false;
    notifyListeners();
  }
}
