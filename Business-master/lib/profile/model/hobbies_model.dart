class HobbiesModel {
  int? id;
  String? name;
  String? image;

  HobbiesModel({this.id, this.name, this.image});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name_ar': this.name,
      'image': this.image,
    };
  }

  factory HobbiesModel.fromMap(Map<String, dynamic> map) {
    return HobbiesModel(
      id: map['id'] as int,
      name: map['name_ar'] ?? 'test delete',
      image: map['image'] ??
          "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png",
    );
  }
}
