import 'package:business/groups_pages/group_details/model/group_details_data_model.dart';
import 'package:business/post/model/user_data_model.dart';

class PostModel {
  int? id;
  String? body;
  UserDataModel? userPostModel;
  int? likesNum;
  late int reactNum;
  int? commentsNum;
  int? sharesNum;
  List<Images>? images;
  List<Videos>? videos;

  PostModel({
    this.id,
    this.body,
    this.userPostModel,
    this.likesNum,
    required this.reactNum,
    this.commentsNum,
    this.sharesNum,
    this.images,
    this.videos,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    userPostModel =
        json['user'] != null ? new UserDataModel.fromJson(json['user']) : null;
    likesNum = json['likes_num'];
    reactNum = json['react_num'];
    commentsNum = json['comments_num'];
    sharesNum = json['shares_num'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    if (json['videos'] != null) {
      videos = [];
      json['videos'].forEach((v) {
        videos!.add(new Videos.fromJson(v));
      });
    }
  }

  PostModel copyWith({
    int? id,
    String? body,
    PublisherId? user,
    int? likesNum,
    int? reactNum,
    int? commentsNum,
    int? sharesNum,
    List<Images>? images,
    List<Videos>? videos,
  }) {
    return PostModel(
      id: id ?? this.id,
      body: body ?? this.body,
      userPostModel: userPostModel ?? this.userPostModel,
      likesNum: likesNum ?? this.likesNum,
      reactNum: reactNum ?? this.reactNum,
      commentsNum: commentsNum ?? this.commentsNum,
      sharesNum: sharesNum ?? this.sharesNum,
      images: images ?? this.images,
      videos: videos ?? this.videos,
    );
  }
}
