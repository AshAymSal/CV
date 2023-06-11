import 'package:business/chatting/model/recent_chat_model.dart';
import 'package:business/chatting/model/unread_count_model.dart';
import 'package:business/chatting/repos/recent_chat_repo.dart';
import 'package:business/chatting/screen/chatting_details/chat_message_screen.dart';
import 'package:business/core/network/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

/// Get Recent Chat stream
final recentChatStreamProvider =
    StreamProvider.autoDispose<List<RecentChatModel>>((ref) {
  return RecentChatRepo.instance.getRecentChat(
      (ref.read(sharedPreferencesServiceProvider).getUserData())!);
});
final unreadStreamProvider = StreamProvider.autoDispose
    .family<UnreadCountModel, RecentChatModel>((ref, model) {
  return RecentChatRepo.instance.getUnreadMessageCount(model: model);
});

final recentChatProvider =
    ChangeNotifierProvider<RecentChatProvider>((ref) => RecentChatProvider());

class RecentChatProvider with ChangeNotifier {
  TextEditingController searchTextEditingController = TextEditingController();
  List<RecentChatModel> searchRecentChatList = [];

  void onSearchSubmit({required List<RecentChatModel> recentChatList}) {
    recentChatList.forEach((element) {
      if (element.receiverData!.name
          .toLowerCase()
          .startsWith(searchTextEditingController.text.toLowerCase())) {
        searchRecentChatList.add(element);
      }
    });
    notifyListeners();
  }

  void onPressedCancelButton() {
    searchTextEditingController.clear();
    searchRecentChatList.clear();
    notifyListeners();
  }

  void navigationToChatMessageScreen({
    required context,
    required docIdChat,
    required RecentChatModel recentChatModel,
  }) {
    Get.to(
      () => ChatMessageScreen(
        recentChatModel: recentChatModel,
      ),
    );
  }
}
