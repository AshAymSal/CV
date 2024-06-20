class notificationModel {
  String? id;
  String? fromWhom;
  String? type;
  String? date;
  String? seen;

  notificationModel({this.id, this.fromWhom, this.type, this.date, this.seen});

  factory notificationModel.withJson(Map<String, dynamic> a) {
    //print(a["id"] + "   " + a["seen"]);
    notificationModel re = notificationModel(
        fromWhom: a["fromWhom"],
        id: a["id"],
        type: a["type"],
        date: a["date"],
        seen: a["seen"]);
    return re;
  }
}
