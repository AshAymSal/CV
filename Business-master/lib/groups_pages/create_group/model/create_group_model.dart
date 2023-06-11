import 'package:dio/dio.dart';

class CreateGroupModel {
  String? token, name, description, rules, privacy, category_id, publisher_id;
  MultipartFile? profile_image, cover_image;

  CreateGroupModel({
    this.token,
    this.name,
    this.description,
    this.rules,
    this.privacy,
    this.category_id,
    this.publisher_id,
    this.profile_image,
    this.cover_image,
  });

  factory CreateGroupModel.fromMap(Map<String, dynamic> map) {
    return new CreateGroupModel(
      token: map['token'] as String?,
      name: map['name'] as String?,
      description: map['description'] as String?,
      rules: map['rules'] as String?,
      privacy: map['privacy'] as String?,
      category_id: map['category_id'] as String?,
      publisher_id: map['publisher_id'] as String?,
      profile_image: map['profile_image'] as MultipartFile?,
      cover_image: map['cover_image'] as MultipartFile?,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'token': this.token,
      'name': this.name,
      'description': this.description,
      'rules': this.rules,
      'privacy': this.privacy,
      'category_id': this.category_id,
      'publisher_id': this.publisher_id,
      'profile_image': this.profile_image,
      'cover_image': this.cover_image,
    } as Map<String, dynamic>;
  }
}
