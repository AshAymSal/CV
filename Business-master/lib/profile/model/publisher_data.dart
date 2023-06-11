class PublisherData {
  String? name;
  String? personalImage;
  int? id;

  PublisherData({this.name, this.personalImage, this.id});

  PublisherData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    personalImage = json['personal_image'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['personal_image'] = this.personalImage;
    data['id'] = this.id;
    return data;
  }
}
