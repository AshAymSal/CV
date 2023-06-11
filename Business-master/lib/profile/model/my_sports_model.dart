import 'package:business/profile/model/sports_model.dart';

class MySportsModel {
  int? id;
  Owner? owner;
  SportsModel? sport;

  MySportsModel({this.id, this.owner, this.sport});

  MySportsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    sport =
        json['sport'] != null ? new SportsModel.fromMap(json['sport']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    if (this.sport != null) {
      data['sport'] = this.sport!.toMap();
    }
    return data;
  }
}

class Owner {
  String? name;
  String? personalImage;
  int? userId;

  Owner({this.name, this.personalImage, this.userId});

  Owner.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    personalImage = json['personal_image'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['personal_image'] = this.personalImage;
    data['user_id'] = this.userId;
    return data;
  }
}
