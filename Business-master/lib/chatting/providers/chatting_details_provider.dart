import 'dart:io';

import 'package:business/chatting/model/message_model.dart';
import 'package:business/chatting/model/recent_chat_model.dart';
import 'package:business/chatting/repos/chatting_details_repo.dart';
import 'package:business/chatting/screen/recent_chat/resent_chat_screen.dart';
import 'package:business/core/network/local/shared_preferences_service.dart';
import 'package:business/helper/functions.dart';
import 'package:business/profile/view/profile_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

final checkIfUserActiveStream = StreamProvider.family.autoDispose(
  (ref, int receiverId) =>
      ChattingDetailsRepo.instance.getUserActive(receiverId: receiverId),
);
final getChatMessageStream = StreamProvider.family.autoDispose(
  (ref, RecentChatModel? recentChatModel) =>
      ChattingDetailsRepo.instance.getChatMessage(model: recentChatModel!),
);
final getStatusWriteNowStream = StreamProvider.autoDispose(
  (ref) => ChattingDetailsRepo.instance.getStatusWriteNow(),
);

final updateMessageSeen =
    FutureProvider.family((ref, MessageModel messageModel) {
  return ChattingDetailsRepo.instance.updateMessageSeen(
    messageModel: messageModel,
  );
});

final chattingDetailsProvider = ChangeNotifierProvider.autoDispose
    .family((ref, RecentChatModel? recentChatModel) {
  return ChattingDetailsProvider(recentChatModel!,
      (ref.read(sharedPreferencesServiceProvider).getUserData())!.id!);
});

class ChattingDetailsProvider with ChangeNotifier {
  ChattingDetailsProvider(this.recentChatModel, this.clientId);

  late RecentChatModel recentChatModel;
  var insertMessageController = TextEditingController();
  late int clientId;
  bool isUploadingChatImage = false;

  Future updateSeen() async {
    await ChattingDetailsRepo.instance.updateSeenCount();
  }

  Future<void> setMessageInChat({
    required String docIdChat,
    required bool isMultiMedia,
    String? images,
  }) async {
    String msg = insertMessageController.text;
    insertMessageController.clear();
    notifyListeners();
    if (msg.trim().length > 0 || isMultiMedia) {
      await ChattingDetailsRepo.instance.setMessageInChat(
        docIdChat: docIdChat,
        messageModel: MessageModel(
          message: isMultiMedia ? '' : msg.trim(),
          clientId: clientId,
          receiverId: recentChatModel.receiverData!.userId,
          createAt: Timestamp.now().millisecondsSinceEpoch,
          image: isMultiMedia ? images : "",
          seen: false,
        ),
        isMedia: isMultiMedia,
      );
      notifyListeners();
    }
  }

  Future setClientWriteNow({required docId, bool? closeWriteNow}) async {
    bool typing = false;
    if (closeWriteNow != null) {
      typing = false;
    } else if (insertMessageController.text.length > 0) {
      typing = true;
    }
    ChattingDetailsRepo.instance.setClientWriteNow(
      writeNow: typing,
    );
    notifyListeners();
  }

  void openGallery(
      {required String docIdChat, required BuildContext context}) async {
    File? pickedFile;

    ///TODO :
    // pickedFile =
    //     await ImageSelector.instance.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      isUploadingChatImage = true;
      notifyListeners();

      /// Upload Image
    } else {
      print('No image selected.');
    }
    isUploadingChatImage = false;
    notifyListeners();
  }

  void navigationToServerErrorScreen(context) {
    showToast(msg: 'حدثت مشكلة');
  }

  void navigationToRecentChatOrCenterScreen(
      {required BuildContext context,
      bool fromRecentChat = true,
      int? branchId}) {
    if (fromRecentChat) {
      Get.replace(() => ResentChatScreen());
    } else {
      Get.replace(
        () => ProfileScreen(
          userId: branchId,
        ),
      );
    }
  }
}
