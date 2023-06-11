import 'package:business/chatting/model/recent_chat_model.dart';
import 'package:business/chatting/repos/chatting_details_repo.dart';
import 'package:business/chatting/screen/chatting_details/chat_message_screen.dart';
import 'package:business/core/network/local/cache_helper.dart';
import 'package:business/core/network/local/shared_preferences_service.dart';
import 'package:business/services/models/all_services_model.dart';
import 'package:business/services/repos/follow_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

final servicesDetailsViewModel =
    ChangeNotifierProvider.family<ServicesDetailsViewModel, ServicesModel>(
        (ref, model) => ServicesDetailsViewModel(
            ref, ref.read(sharedPreferencesServiceProvider), model));

class ServicesDetailsViewModel extends ChangeNotifier {
  ServicesDetailsViewModel(
      this.ref, this.sharedPreferencesService, this.model) {
    myToken = CacheHelper.getStringData(key: "myToken");
  }

  final ProviderReference ref;
  late ServicesModel model;
  final SharedPreferencesService sharedPreferencesService;

  String? myToken;
  bool isLoading = false;

  Future navigationToChatMessageScreen(ServicesModel productDetails) async {
    RecentChatModel recentChatModel = (await ChattingDetailsRepo.instance
        .checkCreatedThread(
            receiverName: productDetails.publisherData!.name!,
            receiverImage: productDetails.publisherData!.personalImage!,
            receiverId: productDetails.publisherData!.id!,
            clientName: sharedPreferencesService.getUserData()!.name!,
            clientImage: sharedPreferencesService.getUserData()!.personalImage!,
            clientId: sharedPreferencesService.getUserData()!.id!));

    Get.to(
      () => ChatMessageScreen(
        recentChatModel: recentChatModel,
      ),
    );
  }

  Future followPublisher() async {
    isLoading = true;
    notifyListeners();
    try {
      await FollowRepo.addFollow(
        token: myToken!,
        followingId: model.publisherData!.id!,
      );
      model = model.copyWith(isFollow: true);
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }

  Future unFollowPublisher() async {
    isLoading = true;
    notifyListeners();
    try {
      await FollowRepo.unFollow(
          token: myToken!, followingId: model.publisherData!.id!);
      model = model.copyWith(isFollow: false);
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }
}
