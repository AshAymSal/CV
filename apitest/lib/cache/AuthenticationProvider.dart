import 'package:apitest/cache/AuthenticationRepo.dart';
import 'package:apitest/cache/AuthenticationShardPreferences.dart';
import 'package:flutter/cupertino.dart';
import '../models/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/user.dart';

class authProvider extends ChangeNotifier {
  userModel? user;

  static authProvider getWatch(BuildContext context) {
    //print("watch");
    return context.watch<authProvider>();
  }

  static authProvider getRead(BuildContext context) {
    //print("read");
    return context.read<authProvider>();
  }

  Future<userModel?> checkAuth() async {
    var SPName = sharedPreferences.getName();
    var SPPass = sharedPreferences.getPassword();
    var SPID = sharedPreferences.getID();
    print(SPID + " " + SPName + "  " + SPPass);
    if (SPID != "") {
      user = userModel(id: SPID, name: SPName, password: SPPass);
      // notifyListeners();
    }
    return user;
  }

  Future signIn(String name, String password) async {
    user = await myRepo().signIn(name, password);
    notifyListeners();

    if (user != null) {
      sharedPreferences.setID(user!.id!);
      sharedPreferences.setName(user!.name!);
      sharedPreferences.setPassword(user!.password!);
    }
    print("Signed In");
  }

  Future signOut() async {
    user = null;
    notifyListeners();

    sharedPreferences.setID("");
    sharedPreferences.setName("");
    sharedPreferences.setPassword("");
    print("Signed Out");
  }
}
