class MessageModel {
  String? message, image;
  int? clientId;
  int? receiverId;
  String? docId;
  int? createAt;
  bool? seen;

  MessageModel({
    this.message,
    this.image,
    this.clientId,
    this.receiverId,
    this.createAt,
    this.seen,
    this.docId,
  });

  Map<String, dynamic> toMap() {
    return {
      'message': this.message,
      'image': this.image,
      'clientId': this.clientId,
      'receiverId': this.receiverId,
      'createAt': this.createAt,
      'seen': this.seen,
      'docId': this.docId,
    }..removeWhere((key, value) => value == null);
  }

  factory MessageModel.fromMap(Map<String, dynamic> map, String documentId) {
    return MessageModel(
      message: map['message'] as String,
      receiverId: map['receiverId'] as int,
      image: map['image'] as String,
      clientId: map['clientId'],
      createAt: map['createAt'] as int,
      seen: map['seen'] as bool,
      docId: documentId,
    );
  }
}
