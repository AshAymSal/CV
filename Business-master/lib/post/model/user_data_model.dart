class UserDataModel {
  late String name, personalImage;
  late int id;

  UserDataModel({
    required this.name,
    required this.personalImage,
    required this.id,
  });

  UserDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    personalImage = json['personal_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['personal_image'] = this.personalImage;
    return data;
  }
}
