import 'package:business/post/model/user_data_model.dart';

class LikePostModel {
  List<LikesDataModel>? likes;

  LikePostModel({this.likes});

  LikePostModel.fromJson(Map<String, dynamic> json) {
    if (json['likes'] != null) {
      likes = [];
      json['likes'].forEach((v) {
        likes!.add(new LikesDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.likes != null) {
      data['likes'] = this.likes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LikesDataModel {
  int? id;
  String? modelId;
  String? modelType;
  int? reactId;
  UserDataModel? userPostModel;

  LikesDataModel(
      {this.id,
      this.modelId,
      this.modelType,
      this.reactId,
      this.userPostModel});

  LikesDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelId = json['model_id'];
    modelType = json['model_type'];
    reactId = json['reactId'];
    userPostModel =
        json['user'] != null ? new UserDataModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['model_id'] = this.modelId;
    data['model_type'] = this.modelType;
    data['reactId'] = this.reactId;
    if (this.userPostModel != null) {
      data['user'] = this.userPostModel!.toJson();
    }
    return data;
  }
}
