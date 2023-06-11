class MusicModel {
  int? id;
  String? userId;
  String? name;
  String? image;
  String?music;

 // MusicId? musicId;

  MusicModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.image,
    required this.music,
  });

  MusicModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    name = json['name'];
    image = json['image'];
    music = json['music'];
   // musicId = json['musicId'] != null ? new MusicId.fromJson(json['musicId']) : null;//Mina Removing musicId class 5/1/2022
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
  /*  if (this.musicId != null) {
      data['musicId'] = this.musicId!.toJson();
    }*/
    return data;
  }
}
/*//Mina Removing musicId class 5/1/2022
class MusicId {
  int? id;
  String? name;
  String? image;
  String? music;

  MusicId({
    required this.id,
    required this.name,
    required this.image,
    required this.music,
  });

  MusicId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    music = json['music'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['music'] = this.music;
    return data;
  }
}
*/
