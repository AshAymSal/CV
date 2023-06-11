class InspirationModel {
  int? id;
  String? userId;
  String? inspirerendeId;
  User? user;

  InspirationModel({
    this.id,
    this.userId,
    this.inspirerendeId,
    this.user,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'user_id': this.userId,
      'inspirerende_id': this.inspirerendeId,
      'user': this.user,
    };
  }

  factory InspirationModel.fromMap(Map<String, dynamic> map) {
    return InspirationModel(
      id: map['id'] ?? '',
      userId: map['user_id'] ?? '',
      inspirerendeId: map['inspirerende_id'] ?? '',
      user: map['user'] != null ? User.fromJson(map['user']) : null,
    );
  }
}

class User {
  String? name;
  String? personalImage;
  int? id;
  String? friendship;

  User({this.name, this.personalImage, this.id, this.friendship});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    personalImage = json['personal_image'];
    id = json['id'];
    friendship = json['friendship'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['personal_image'] = this.personalImage;
    data['id'] = this.id;
    data['friendship'] = this.friendship;
    return data;
  }
}
