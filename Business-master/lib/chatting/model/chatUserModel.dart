class ChatUserModel {
  String name, image;
  int userId;

  ChatUserModel({
    required this.name,
    required this.image,
    required this.userId,
  });

  factory ChatUserModel.fromMap(Map<String, dynamic> map) {
    return ChatUserModel(
        image: map["image"], name: map["name"], userId: map["userId"]);
  }

  Map<String, dynamic> toMap() {
    return {'image': this.image, 'name': this.name, "userId": this.userId};
  }
}
