import 'package:business/post/model/post_model.dart';

class GroupDetailsModel {
  PageOrGroupDetails? details;
  int? register;
  int? isAdmin;
  List<PostModel>? groupPosts;

  GroupDetailsModel(
      {this.details, this.register, this.isAdmin, this.groupPosts});

  GroupDetailsModel.fromJson(Map<String, dynamic> json) {
    details = json['details'] != null
        ? new PageOrGroupDetails.fromJson(json['details'])
        : null;
    register = json['register'];
    isAdmin = json['isAdmin'];
    if (json['group_posts'] != null) {
      groupPosts = [];
      json['group_posts'].forEach((v) {
        groupPosts!.add(new PostModel.fromJson(v));
      });
    }
  }
}

class PageOrGroupDetails {
  int? id;
  String? name;
  String? coverImage;
  String? description;
  String? rules;
  String? privacy;
  CategoryId? categoryId;
  PublisherId? publisherId;
  int? membersCount;

  PageOrGroupDetails(
      {this.id,
      this.name,
      this.coverImage,
      this.description,
      this.rules,
      this.privacy,
      this.categoryId,
      this.publisherId,
      this.membersCount});

  PageOrGroupDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coverImage = json['cover_image'];
    description = json['description'];
    rules = json['rules'];
    privacy = json['privacy'];
    categoryId = json['category_id'] != null
        ? new CategoryId.fromJson(json['category_id'])
        : null;
    publisherId = json['publisher_id'] != null
        ? new PublisherId.fromJson(json['publisher_id'])
        : null;
    membersCount = json['members_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['cover_image'] = this.coverImage;
    data['description'] = this.description;
    data['rules'] = this.rules;
    data['privacy'] = this.privacy;
    if (this.categoryId != null) {
      data['category_id'] = this.categoryId!.toJson();
    }
    if (this.publisherId != null) {
      data['publisher_id'] = this.publisherId!.toJson();
    }
    data['members_count'] = this.membersCount;
    return data;
  }
}

class CategoryId {
  int? id;
  String? image;
  String? name;

  CategoryId({this.id, this.image, this.name});

  CategoryId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    return data;
  }
}

class PublisherId {
  String? name;
  String? personalImage;

  PublisherId({this.name, this.personalImage});

  PublisherId.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    personalImage = json['personal_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['personal_image'] = this.personalImage;
    return data;
  }
}

class Images {
  int? id;
  String? filename;
  String? mediaType;
  String? modelType;
  String? modelId;

  Images({
    this.id,
    this.filename,
    this.mediaType,
    this.modelType,
    this.modelId,
  });

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    filename = json['filename'];
    mediaType = json['mediaType'] ?? '';
    modelType = json['model_type'] ?? '';
    modelId = json['model_id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['filename'] = this.filename;
    data['mediaType'] = this.mediaType;
    data['model_type'] = this.modelType;
    data['model_id'] = this.modelId;
    return data;
  }
}

class Videos {
  int? id;
  String? filename;
  String? mediaType;
  String? modelType;
  String? modelId;

  Videos({
    this.id,
    this.filename,
    this.mediaType,
    this.modelType,
    this.modelId,
  });

  Videos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    filename = json['filename'];
    mediaType = json['mediaType'];
    modelType = json['model_type'];
    modelId = json['model_id'];
  }
}
