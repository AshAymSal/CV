class userModel {
  String? name;
  String? id;
  String? password;
  String? relative;

  userModel({this.id, this.name, this.password, this.relative});

  factory userModel.withJson(Map<String, dynamic> a) {
    userModel re = userModel(
        name: a["name"],
        id: a["id"],
        password: a["password"],
        relative: a["relative"]);
    return re;
  }
}
