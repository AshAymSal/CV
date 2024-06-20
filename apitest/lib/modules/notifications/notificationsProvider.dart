import 'dart:convert';

import 'package:apitest/Opirations.dart';
import 'package:apitest/constants/Texts.dart';
import 'package:apitest/models/notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../cache/AuthenticationRepo.dart';

class notificationsProvider extends ChangeNotifier {
  static notificationsProvider getWatch(BuildContext context) {
    //print("watch");
    return context.watch<notificationsProvider>();
  }

  static notificationsProvider getRead(BuildContext context) {
    //print("read");
    return context.read<notificationsProvider>();
  }

  List allNotifications = [];
  bool isLoaded = false;
  int n = 0;

  Future getAllNotificaions(String id) async {
    var repo = notificationsRepo();
    repo.getAllNotificaions(id).then((value) {
      allNotifications = value;
      isLoaded = true;
      n = repo.getN();
      notifyListeners();
    });
  }

  Future makeAllNotificationsSeen(String id) async {
    notificationsRepo().makeAllNotificationsSeen(id).then((value) {
      //allNotifications.clear();
      notifyListeners();
    });
  }

  Future makeNotificationSeen(String id, String idN) async {
    await notificationsRepo().makeNotificationSeen(id, idN);
  }
}

class notificationsRepo {
  int n = 0;
  int getN() {
    return n;
  }

  Future<List<dynamic>> getAllNotificaions(String id) async {
    var map = new Map<String, dynamic>();
    map["action"] = "GET_NOTIFICATIONS";
    var allNotificationss = [];
    map["USER_ID"] = id;
    var res = await http.post(Uri.parse(baseUrl), body: map);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      if (data["status"]) {
        //var s in data["data"]

        for (var s in data["data"]) {
          allNotificationss.insert(0, notificationModel.withJson(s));
          if (notificationModel.withJson(s).seen == "0") {
            n++;
          }
        }
        print("Get All Notifications : Done  $n");
        //  print();
      }
    }
    return allNotificationss;
  }

  Future makeAllNotificationsSeen(String id) async {
    var map = new Map<String, dynamic>();
    map["action"] = "MAKE_NOTIFICATION_SEEN";
    map["USER_ID"] = id;
    var res = await http.post(Uri.parse(baseUrl), body: map);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      if (data["status"]) {
        print("All Notifications Seen : Done");
      } else {
        print("All Notifications Seen : Failed");
      }
    }
  }

  Future makeNotificationSeen(String id, String idN) async {
    var map = new Map<String, dynamic>();
    map["action"] = "MAKE_NOTIFICATION_SEEN";
    map["USER_ID"] = id;
    map["NOTIFICATION_ID"] = idN;
    var res = await http.post(Uri.parse(baseUrl), body: map);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      if (data["status"]) {
        print("Notification Seen : Done");
      } else {
        print("Notification Seen : Failed");
      }
    }
  }
}
