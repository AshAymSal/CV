class GroupsPagesDataModel {
  int? id;
  String? name;
  String? profileImage;
  int? privacy;
  int? membersCount;
  int? entered;

  GroupsPagesDataModel(
      {this.id,
      this.name,
      this.profileImage,
      this.privacy,
      this.membersCount,
      this.entered});

  GroupsPagesDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profileImage = json['profile_image'];
    privacy = json['privacy'];
    membersCount = json['members_count'];
    entered = json['entered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profile_image'] = this.profileImage;
    data['privacy'] = this.privacy;
    data['members_count'] = this.membersCount;
    data['entered'] = this.entered;
    return data;
  }
}
