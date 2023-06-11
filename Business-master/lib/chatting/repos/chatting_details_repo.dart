import 'dart:io';

import 'package:business/chatting/model/chatUserModel.dart';
import 'package:business/chatting/model/message_model.dart';
import 'package:business/chatting/model/recent_chat_model.dart';
import 'package:business/chatting/model/typingModel.dart';
import 'package:business/chatting/model/unread_count_model.dart';
import 'package:business/chatting/model/user_specialist_model.dart';
import 'package:business/core/network/remote/firebase_caller.dart';
import 'package:business/core/network/remote/firestore_paths.dart';
import 'package:business/profile/model/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ChattingDetailsRepo {
  ChattingDetailsRepo._();

  String chatPath = '';

  static final instance = ChattingDetailsRepo._();
  RecentChatModel? recentChatModel;

  final _service = FirebaseServicesCaller.instance;

  Stream<List<MessageModel>> getChatMessage({required RecentChatModel? model}) {
    recentChatModel = model!;
    return _service.collectionStream(
      path: FirestorePaths.chatCollectionPath(model.docId!),
      builder: (data, documentId) => MessageModel.fromMap(data!, documentId),
      queryBuilder: (query) => query.orderBy("createAt", descending: true),
    );
  }

  /// Check if user active or not
  Stream<UserSpecialistActiveModel> getUserActive({required int? receiverId}) =>
      _service.documentStream(
        path: FirestorePaths.userCollection(receiverId.toString()),
        builder: (data, documentId) => UserSpecialistActiveModel.fromMap(data!),
      );

  Future<void> setMessageInChat({
    required docIdChat,
    required MessageModel messageModel,
    required bool isMedia,
  }) async {
    if (recentChatModel != null) {
      /// increase Count by one
      _service.getData(
        path: FirestorePaths.unreadCountCollectionPath(
          chatPath: docIdChat,
          userId: recentChatModel!.receiverData!.userId.toString(),
        ),
        builder: (Map<String, dynamic>? data, String? documentId) {
          UnreadCountModel unreadCountModel = UnreadCountModel.fromMap(data!);
          _service.setData(
            path: FirestorePaths.unreadCountCollectionPath(
              chatPath: docIdChat,
              userId: recentChatModel!.receiverData!.userId.toString(),
            ),
            data:
                UnreadCountModel(unreadCount: unreadCountModel.unreadCount! + 1)
                    .toMap(),
          );
        },
      );

      /// Add last message
      _service.setData(
        path: FirestorePaths.threadDocumentPath(
          docIdChat,
        ),
        merge: true,
        data: {
          "lastMessage": isMedia ? 'صورة' : messageModel.message,
          "recentDate": Timestamp.now(),
        },
      );

      /// add message
      _service.addData(
        path: FirestorePaths.chatCollectionPath(docIdChat),
        data: messageModel.toMap(),
      );
    }
  }

  Future<List<ProfileModel>?> uploadChatImage(
      File image, BuildContext context) async {}

  Future updateMessageSeen({required MessageModel messageModel}) async {
    if (recentChatModel != null) {
      _service.setData(
          path: FirestorePaths.messageCollection(
              recentChatModel!.docId!, messageModel.docId!),
          data: {"seen": true},
          merge: true);
    }
  }

  Future updateSeenCount() async {
    if (recentChatModel != null) {
      await _service.setData(
        path: FirestorePaths.unreadCountCollectionPath(
          chatPath: recentChatModel!.docId!,
          userId: recentChatModel!.clientData!.userId.toString(),
        ),
        data: UnreadCountModel(unreadCount: 0).toMap(),
      );
    }
  }

  Stream<bool> getStatusWriteNow() => _service.documentStream(
        path: FirestorePaths.typingCollection(recentChatModel!.docId!,
            recentChatModel!.receiverData!.userId.toString()),
        builder: (data, documentId) => TypingModel.fromMap(data!).typing!,
      );

  Future setClientWriteNow({required bool writeNow}) async {
    if (recentChatModel != null) {
      _service.setData(
        path: FirestorePaths.typingCollection(recentChatModel!.docId!,
            recentChatModel!.clientData!.userId.toString()),
        data: TypingModel(typing: writeNow).toMap(),
        merge: true,
      );
    }
  }

  Future<RecentChatModel> checkCreatedThread({
    required String receiverName,
    required String receiverImage,
    required int receiverId,
    required String clientName,
    required String clientImage,
    required int clientId,
  }) async {
    if (clientId > receiverId)
      chatPath = "$clientId-$receiverId";
    else
      chatPath = "$receiverId-$clientId";

    return _service.getData(
      path: FirestorePaths.docChatCollectionPath(
        chatPath,
      ),
      builder: (Map<String, dynamic>? data, String? documentId) {
        /// Create new thread
        if (data == null) {
          recentChatModel = createNewThread(
              receiverName: receiverName,
              receiverImage: receiverImage,
              receiverId: receiverId,
              clientName: clientName,
              clientImage: clientImage,
              clientId: clientId);
          return recentChatModel!;
        } else {
          recentChatModel = RecentChatModel.fromMap(
            map: data,
            clientId: clientId,
            documentId: documentId!,
          );
          return recentChatModel!;
        }
      },
    );
  }

  createNewThread({
    required String receiverName,
    required String receiverImage,
    required int receiverId,
    required String clientName,
    required String clientImage,
    required int clientId,
  }) {
    RecentChatModel recentChatModel = RecentChatModel(
      recentDate: Timestamp.now(),
      docId: chatPath,
      lastMessage: '',
      clientData: ChatUserModel(
        name: clientName,
        image: clientImage,
        userId: clientId,
      ),
      receiverData: ChatUserModel(
        name: receiverName,
        image: receiverImage,
        userId: receiverId,
      ),
      usersId: [clientId, receiverId],
    );
    _service.setData(
      path: FirestorePaths.threadDocumentPath(
        chatPath,
      ),
      data: recentChatModel.toMap(),
    );
    _service.setData(
      path: FirestorePaths.unreadCountCollectionPath(
        chatPath: chatPath,
        userId: receiverId.toString(),
      ),
      data: UnreadCountModel(unreadCount: 0).toMap(),
    );
    _service.setData(
      path: FirestorePaths.unreadCountCollectionPath(
        chatPath: chatPath,
        userId: recentChatModel.clientData!.userId.toString(),
      ),
      data: UnreadCountModel(unreadCount: 0).toMap(),
    );

    return recentChatModel;
  }
}
