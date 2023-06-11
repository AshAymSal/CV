class ViewersModel {
  String? id;
  String? name;
  String? personalImage;

  ViewersModel({
    this.id,
    this.name,
    this.personalImage,
  });

  ViewersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    personalImage = json['personal_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['personal_image'] = this.personalImage;
    return data;
  }
}
