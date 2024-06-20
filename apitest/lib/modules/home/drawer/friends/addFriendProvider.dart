import 'dart:convert';

import 'package:apitest/constants/Texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:apitest/models/user.dart';

class addFriendProvider extends ChangeNotifier {
  static addFriendProvider getWatch(BuildContext context) {
    //print("watch");
    return context.watch<addFriendProvider>();
  }

  static addFriendProvider getRead(BuildContext context) {
    //print("read");
    return context.read<addFriendProvider>();
  }

  List search = [];
  bool isLoaded = false;

  Future<List<dynamic>> getSearch(String id, String name) async {
    addFriendRepo().getSearch(id, name).then((value) {
      search = value;
      isLoaded = true;
      notifyListeners();
    });
    return search;
  }

  void clearSearch() {
    search.clear();
    isLoaded = false;
    notifyListeners();
  }

  Future sendRequest(BuildContext context, String idS, String idR) async {
    await addFriendRepo().sendRequest(context, idS, idR);
  }

  Future cancelRequest(BuildContext context, String idS, String idR) async {
    await addFriendRepo().cancelRequest(context, idS, idR);
  }
}

class addFriendRepo {
  Future<List<dynamic>> getSearch(String id, String name) async {
    var map = new Map<String, dynamic>();
    map["action"] = "GET_USERS_BY_NAME";
    map["USER_NAME"] = name;
    map["USER_ID"] = id;
    var search = [];
    var res = await http.post(Uri.parse(baseUrl), body: map);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      if (data["status"]) {
        for (var s in data["data"]) {
          search.add(userModel.withJson(s));
        }
      }
    }
    return search;
  }

  Future sendRequest(BuildContext context, String idS, String idR) async {
    var map = new Map<String, dynamic>();
    map["action"] = "SEND_REQUEST";
    map["USER_ID"] = idS;
    map["RECEIVER_ID"] = idR;

    var res = await http.post(Uri.parse(baseUrl), body: map);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      if (data["status"]) {
        print("Send Requset : Done");
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Done")));
      } else {
        if (data["message"] == "Already Sent") {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Already Sent")));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Already Friend")));
        }
        print("Send Requset : Failed  ${data["message"]}");
      }
    }
  }

  Future cancelRequest(BuildContext context, String idS, String idR) async {
    var map = new Map<String, dynamic>();
    map["action"] = "DENY_REQUEST";
    map["SENDER_ID"] = idS;
    map["USER_ID"] = idR;

    var res = await http.post(Uri.parse(baseUrl), body: map);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      if (data["status"]) {
        print("Cancel Requset : Done");
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Cancel Request :Done")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Cancel Request : Failed")));
        print("Cancel Request : Failed  ");
      }
    }
  }
}
