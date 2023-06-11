class CommentsModel {
  int? id;
  String? body;
  int? modelId;
  String? modelType;
  User? user;
  int? likesNum;
  int? commentsNum;
  int? isLiked;
  int? myComment;

  CommentsModel({
    this.id,
    this.body,
    this.modelId,
    this.modelType,
    this.user,
    this.likesNum,
    this.commentsNum,
    this.isLiked,
    this.myComment,
  });

  CommentsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    modelId = json['model_id'] as int;
    modelType = json['model_type'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    likesNum = json['likes_num'];
    commentsNum = json['comments_num'];
    isLiked = json['isLiked'];
    myComment = json['myComment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['body'] = this.body;
    data['model_id'] = this.modelId;
    data['model_type'] = this.modelType;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['likes_num'] = this.likesNum;
    data['comments_num'] = this.commentsNum;
    data['isLiked'] = this.isLiked;
    data['myComment'] = this.myComment;
    return data;
  }

  CommentsModel copyWith({
    int? id,
    String? body,
    int? modelId,
    String? modelType,
    User? user,
    int? likesNum,
    int? commentsNum,
    int? isLiked,
    int? myComment,
    Map<String, dynamic>? data,
  }) {
    return CommentsModel(
      id: id ?? this.id,
      body: body ?? this.body,
      modelId: modelId ?? this.modelId,
      modelType: modelType ?? this.modelType,
      user: user ?? this.user,
      likesNum: likesNum ?? this.likesNum,
      commentsNum: commentsNum ?? this.commentsNum,
      isLiked: isLiked ?? this.isLiked,
      myComment: isLiked ?? this.myComment,
    );
  }
}

class User {
  int? id;
  String? name;
  String? image;

  User({this.id, this.name, this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
