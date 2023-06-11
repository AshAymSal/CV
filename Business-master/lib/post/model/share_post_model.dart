class SharePostModel {
  List<ShareDataModel>? shares;

  SharePostModel({this.shares});

  SharePostModel.fromJson(Map<String, dynamic> json) {
    if (json['shares'] != null) {
      shares = [];
      json['shares'].forEach((v) {
        shares!.add(new ShareDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shares != null) {
      data['shares'] = this.shares!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShareDataModel {
  int? id;
  PublisherId? publisherId;

  ShareDataModel({this.id, this.publisherId});

  ShareDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    publisherId = json['publisherId'] != null
        ? new PublisherId.fromJson(json['publisherId'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.publisherId != null) {
      data['publisherId'] = this.publisherId!.toJson();
    }
    return data;
  }
}

class PublisherId {
  int? id;
  String? name;
  String? personalImage;

  PublisherId({this.id, this.name, this.personalImage});

  PublisherId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    personalImage = json['personal_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['personal_image'] = this.personalImage;
    return data;
  }
}
