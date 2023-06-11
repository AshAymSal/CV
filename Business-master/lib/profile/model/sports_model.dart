class SportsModel {
  int? id;
  String? name;
  String? image;

  SportsModel({this.id, this.name, this.image});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name_ar': this.name,
      'image': this.image,
    };
  }

  factory SportsModel.fromMap(Map<String, dynamic> map) {
    return SportsModel(
      id: map['id'] as int,
      name: map['name_ar'] ?? 'test delete',
      image: map['image'] ??
          "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png",
    );
  }
}
