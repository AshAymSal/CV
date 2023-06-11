class GroupMember {
  int? id;
  UserId? userId;
  String? groupId;
  String? state;
  String? isAdmin;
  String? friendship;
  int? friendshipId;
  int? follow;

  GroupMember({
    this.id,
    this.userId,
    this.groupId,
    this.state,
    this.isAdmin,
    this.friendship,
    this.friendshipId,
    this.follow,
  });

  GroupMember.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId =
        json['user_id'] != null ? new UserId.fromJson(json['user_id']) : null;
    groupId = json['group_id'];
    state = json['state'];
    isAdmin = json['isAdmin'];
    friendship = json['friendship'];
    friendshipId = json['friendship_id'];
    follow = json['follow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.userId != null) {
      data['user_id'] = this.userId!.toJson();
    }
    data['group_id'] = this.groupId;
    data['state'] = this.state;
    data['isAdmin'] = this.isAdmin;
    data['friendship'] = this.friendship;
    data['friendship_id'] = this.friendshipId;
    data['follow'] = this.follow;
    return data;
  }

  GroupMember copyWith({
    int? id,
    UserId? userId,
    String? groupId,
    String? state,
    String? isAdmin,
    String? friendship,
    int? friendshipId,
    int? follow,
  }) {
    return GroupMember(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      groupId: groupId ?? this.groupId,
      state: state ?? this.state,
      isAdmin: isAdmin ?? this.isAdmin,
      friendship: friendship ?? this.friendship,
      friendshipId: friendshipId ?? this.friendshipId,
      follow: follow ?? this.follow,
    );
  }
}

class UserId {
  String? name;
  String? personalImage;
  int? userId;

  UserId({this.name, this.personalImage, this.userId});

  UserId.fromJson(Map<String, dynamic> json) {
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
