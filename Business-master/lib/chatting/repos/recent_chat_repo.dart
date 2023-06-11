import 'dart:async';

import 'package:business/chatting/model/recent_chat_model.dart';
import 'package:business/chatting/model/unread_count_model.dart';
import 'package:business/chatting/model/user_specialist_model.dart';
import 'package:business/core/network/remote/firebase_caller.dart';
import 'package:business/core/network/remote/firestore_paths.dart';
import 'package:business/profile/model/profile_model.dart';

class RecentChatRepo {
  RecentChatRepo._();

  static final instance = RecentChatRepo._();

  final _service = FirebaseServicesCaller.instance;

  Stream<List<RecentChatModel>> getRecentChat(ProfileModel clientModel) {
    return _service.collectionStream(
      path: FirestorePaths.threadCollectionPath(),
      builder: (data, documentId) => RecentChatModel.fromMap(
        map: data!,
        clientId: clientModel.id!,
        documentId: documentId,
      ),
      queryBuilder: (query) => query.orderBy("recentDate").where(
            "usersId",
            arrayContains: clientModel.id!,
          ),
    );
  }

  Stream<UnreadCountModel> getUnreadMessageCount(
      {required RecentChatModel model}) {
    return _service.documentStream(
      path: FirestorePaths.unreadCountCollectionPath(
        chatPath: model.docId!,
        userId: model.clientData!.userId.toString(),
      ),
      builder: (data, documentId) => UnreadCountModel.fromMap(data!),
    );
  }

  Future makeUserOnlineOffline({
    required bool status,
    required int clientId,
  }) async =>
      await _service.setData(
          path: FirestorePaths.userCollection(
            clientId.toString(),
          ),
          merge: true,
          data: UserSpecialistActiveModel(active: status).toMap());

  Future saveCurrentUserToken({
    required String userToken,
    required int clientId,
  }) async =>
      await _service.setData(
          path: FirestorePaths.userCollection(
            clientId.toString(),
          ),
          merge: true,
          data: {"token": userToken.toString()});

  Future saveCurrentUserName({
    required String userName,
    required int clientId,
  }) async =>
      await _service.setData(
          path: FirestorePaths.userCollection(
            clientId.toString(),
          ),
          merge: true,
          data: {"name": userName.toString()});
}
