import 'dart:convert';

import 'package:apitest/cache/AuthenticationProvider.dart';
import 'package:apitest/constants/Texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:apitest/models/user.dart';

class FriendsProvider extends ChangeNotifier {
  static FriendsProvider getWatch(BuildContext context) {
    //print("watch");
    return context.watch<FriendsProvider>();
  }

  static FriendsProvider getRead(BuildContext context) {
    //print("read");
    return context.read<FriendsProvider>();
  }

  List friends = [];
  bool isLoaded = false;

  Future getFriends(String id) async {
    // print("getting");
    FriendsRepo().getFriends(id).then((value) {
      friends = value;
      isLoaded = true;
      notifyListeners();
    });
  }

  Future deleteFriend(BuildContext context, String idU, String idF) async {
    FriendsRepo().deleteFriend(context, idU, idF).then((value) {
      friends.clear();
      // notifyListeners();
      getFriends(idU);
    });
  }
}

class FriendsRepo {
  Future<List<dynamic>> getFriends(String id) async {
    var map = new Map<String, dynamic>();
    map["action"] = "GET_FRIENDS";
    map["USER_ID"] = id;
    var friends = [];
    var res = await http.post(Uri.parse(baseUrl), body: map);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      if (data["status"]) {
        for (var s in data["data"]) {
          friends.add(userModel.withJson(s));
        }
        print("Get Friends: Done");
      } else {}
    } else {
      print("Get Friends: Failed");
    }
    return friends;
  }

  Future deleteFriend(BuildContext context, String idU, String idF) async {
    var map = new Map<String, dynamic>();
    map["action"] = "DELETE_FRIEND";
    map["USER_ID"] = idU;
    map["FRIEND_ID"] = idF;
    var res = await http.post(Uri.parse(baseUrl), body: map);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      if (data["status"]) {
        print("$idU + $idF Delete Friend: Done");
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Done")));
      } else {
        print("Delete Friend: Failed");
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Failed")));
      }
    }
  }
}
