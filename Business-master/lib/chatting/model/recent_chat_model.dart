import 'package:business/chatting/model/chatUserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecentChatModel {
  String? docId, lastMessage;

  Timestamp? recentDate;
  ChatUserModel? clientData;
  ChatUserModel? receiverData;
  List<dynamic>? usersId;

  RecentChatModel({
    this.docId,
    this.lastMessage,
    this.recentDate,
    this.clientData,
    this.receiverData,
    this.usersId,
  });

  Map<String, dynamic> toMap() {
    return {
      'docId': this.docId,
      "${clientData!.userId}": clientData!.toMap(),
      "${receiverData!.userId}": receiverData!.toMap(),
      'lastMessage': this.lastMessage,
      'recentDate': this.recentDate,
      'usersId': this.usersId,
    }..removeWhere((key, value) => value == null);
  }

  factory RecentChatModel.fromMap({
    required Map<String, dynamic> map,
    required int clientId,
    required String documentId,
  }) {
    final int receiverId;
    if (map["usersId"][0] == clientId) {
      receiverId = map["usersId"][1];
    } else {
      receiverId = map["usersId"][0];
    }

    return RecentChatModel(
      docId: documentId,
      lastMessage: map['lastMessage'] ?? '',
      recentDate: map['recentDate'] as Timestamp,
      usersId: map['usersId'] ?? List,
      clientData: ChatUserModel.fromMap(map['$clientId']),
      receiverData: ChatUserModel.fromMap(map['$receiverId']),
    );
  }
}
