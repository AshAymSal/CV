import 'package:apitest/constants/Texts.dart';
import 'package:apitest/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class myRepo {
  Future<userModel> signIn(String name, String password) async {
    var map = new Map<String, dynamic>();
    map["action"] = "SIGN_IN";
    map["USER_NAME"] = name;
    map["USER_PASSWORD"] = password;

    var res = await http.post(Uri.parse(baseUrl), body: map);
    var user = null;
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      if (data["status"]) {
        print(data["data"]);
        user = userModel.withJson(data["data"][0]);
      }
    }
    return user;
  }

  Future<String> signUp(String name, String password) async {
    var map = new Map<String, dynamic>();
    map["action"] = "SIGN_UP";
    map["USER_NAME"] = name;
    map["USER_PASSWORD"] = password;

    var res = await http.post(Uri.parse(baseUrl), body: map);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      if (data["status"]) {
        print("Signed Up");
        return "Done";
      }
    }
    return "Exists";
  }
}
