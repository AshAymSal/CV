class UnreadCountModel {
  int? unreadCount;

  UnreadCountModel({this.unreadCount});

  Map<String, dynamic> toMap() {
    return {
      'unreadCount': this.unreadCount,
    };
  }

  factory UnreadCountModel.fromMap(Map<String, dynamic> map) {
    return UnreadCountModel(
      unreadCount: map['unreadCount'] as int,
    );
  }
}
