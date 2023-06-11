import 'package:business/groups_pages/group_details/model/group_details_data_model.dart';
import 'package:business/home/model/stories_viewer.dart';

class StoryModel {
  int? id;
  String? name;
  String? personalImage;
  List<UserStories>? userStories;

  StoryModel({
    this.id,
    this.name,
    this.personalImage,
    this.userStories,
  });

  StoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] == null ? "usama elgendy " : json['name'];
    personalImage = json['personal_image'] == null
        ? "https://images.unsplash.com/photo-1499363536502-87642509e31b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80"
        : json['personal_image'];
    if (json['user_stories'] != null) {
      userStories = [];
      json['user_stories'].forEach((v) {
        userStories!.add(new UserStories.fromJson(v));
      });
    }
  }
}

class UserStories {
  String? id;
  String? body;
  int? type;
  List<ViewersModel>? viewers;
  Images? images;
  Videos? videos;

  UserStories({
    this.id,
    this.body,
    this.type,
    this.viewers,
    this.images,
    this.videos,
  });

  UserStories.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    body = json['body'] ?? '';
    type = json['type'] ?? 0;
    if (json['viewers'] != null) {
      viewers = [];
      json['viewers'].forEach((v) {
        viewers!.add(new ViewersModel.fromJson(v));
      });
    }
    print(json['image']);
    if (json['image'] != null) {
      images = Images.fromJson(json['image']);
    }
    if (json['video'] != null) {
      videos = Videos.fromJson(json['video']);
    }
  }
}
