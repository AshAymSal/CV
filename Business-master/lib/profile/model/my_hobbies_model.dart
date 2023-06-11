import 'package:business/post/model/user_data_model.dart';
import 'package:business/profile/model/hobbies_model.dart';

class MyHobbiesModel {
  int? id;
  UserDataModel? owner;
  HobbiesModel? hobby;

  MyHobbiesModel({this.id, this.owner, this.hobby});

  MyHobbiesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    owner = json['owner'] != null
        ? new UserDataModel.fromJson(json['owner'])
        : null;
    hobby =
        json['hobby'] != null ? new HobbiesModel.fromMap(json['hobby']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    if (this.hobby != null) {
      data['hobby'] = this.hobby!.toMap();
    }
    return data;
  }
}
