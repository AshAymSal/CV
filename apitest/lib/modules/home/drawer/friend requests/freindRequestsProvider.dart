import 'dart:convert';

import 'package:apitest/constants/Texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class friendRequestsProvider extends ChangeNotifier {
  static friendRequestsProvider getWatch(BuildContext context) {
    //print("watch");
    return context.watch<friendRequestsProvider>();
  }

  static friendRequestsProvider getRead(BuildContext context) {
    //print("read");
    return context.read<friendRequestsProvider>();
  }

  List allRequests = [];
  bool isLoaded = false;

  Future getAllRequests(String id) async {
    friendRequestsRepo().getAllRequests(id).then((value) {
      allRequests = value;
      isLoaded = true;
      notifyListeners();
    });
    print("get");

    return allRequests;
  }

  Future AcceptRequest(BuildContext context, String idR, String idS) async {
    friendRequestsRepo().AcceptRequest(context, idR, idS).then((value) async {
      allRequests.clear();
      notifyListeners();
      await getAllRequests(idR);
    });
  }

  Future DenyRequest(BuildContext context, String idR, String idS) async {
    friendRequestsRepo().DenyRequest(context, idR, idS).then((value) async {
      allRequests.clear();
      notifyListeners();
      await getAllRequests(idR);
    });
  }
}

class friendRequestsRepo {
  Future<List<dynamic>> getAllRequests(String id) async {
    var map = new Map<String, dynamic>();
    map["action"] = "GET_REQUESTS";
    map["USER_ID"] = id;
    var allRequests = [];
    var res = await http.post(Uri.parse(baseUrl), body: map);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      if (data["status"]) {
        for (var s in data["data"]) {
          allRequests.add(s["fromWhom"]);
        }
      }
    }
    return allRequests;
  }

  Future AcceptRequest(BuildContext context, String idR, String idS) async {
    var map = new Map<String, dynamic>();
    map["action"] = "ACCEPT_REQUEST";
    map["USER_ID"] = idR;
    map["SENDER_ID"] = idS;
    var res = await http.post(Uri.parse(baseUrl), body: map);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      if (data["status"]) {
        print("Accept Requset : Done");
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Done")));
      } else {
        print("Accept Requset : Failed");
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Failed")));
      }
    }
  }

  Future DenyRequest(BuildContext context, String idR, String idS) async {
    var map = new Map<String, dynamic>();
    map["action"] = "DENY_REQUEST";
    map["USER_ID"] = idR;
    map["SENDER_ID"] = idS;
    var res = await http.post(Uri.parse(baseUrl), body: map);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      if (data["status"]) {
        print("Deny Requset : Done");
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Done")));
      } else {
        print("Deny Acceptd Requset : Failed");
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Failed")));
      }
    }
  }
}
