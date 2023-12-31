import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:new_travel/blocs/user_bloc.dart';
import 'package:new_travel/pages/profile_edit.dart';
import 'package:new_travel/pages/wellcome.dart';
import 'package:new_travel/utils/next_screen.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:new_travel/utils/toast.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookLogin fbLogin = new FacebookLogin();

  void handleLogout() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Logout?'.tr(),
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            content: Text('Do you really want to Logout?'.tr()),
            actions: <Widget>[
              FlatButton(
                child: Text('Yes').tr(),
                onPressed: () async {
                  Navigator.pop(context);
                  await auth.signOut();
                  await googleSignIn.signOut();
                  fbLogin.logOut();
                  clearAllData();
                  nextScreenCloseOthers(context, WellComePage());
                },
              ),
              FlatButton(
                child: Text('No').tr(),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  void clearAllData() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }

  @override
  Widget build(BuildContext context) {
    final UserBloc ub = Provider.of<UserBloc>(context);

    if (ub.getUid == "0") {
      Future.delayed(Duration(seconds: 1), () {
        openToast(context, 'Please do registration'.tr());
        nextScreen(
            context,
            WellComePage(
              isSkip: true,
            ));
      });
      return Scaffold(
        appBar: AppBar(
          title: Text("No authentication.".tr()),
        ),
      );
    }

    return Scaffold(
        appBar: PreferredSize(
            child: Center(
              child: AppBar(
                centerTitle: false,
                title: Text('My Profile').tr(),
                elevation: 1,
                actions: <Widget>[
                  Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.deepPurpleAccent),
                        borderRadius: BorderRadius.circular(25)),
                    child: FlatButton.icon(
                        onPressed: () => handleLogout(), icon: Icon(
                            // LineIcons.sign_out
                            Icons.logout), label: Text('Logout').tr()),
                  )
                ],
              ),
            ),
            preferredSize: Size.fromHeight(60)),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 35,
          ),
          child: ListView(
            children: <Widget>[
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[300],
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1, color: Colors.grey, //Colors.grey[800]
                      ),
                      color: Colors.grey[500],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: CachedNetworkImageProvider("ub.imageUrl"),
                          fit: BoxFit.cover)),
                ),
              ),
              Align(
                heightFactor: 1.5,
                child: FlatButton.icon(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    textColor: Colors.white,
                    color: Colors.blueAccent,
                    onPressed: () {
                      nextScreen(
                          context,
                          ProfileEditPage(
                            imageUrl: ub.imageUrl,
                            name: ub.name,
                          ));
                    },
                    icon: Icon(
                      Icons.edit,
                      size: 18,
                    ),
                    label: Text('Edit Profile').tr()),
              ),
              SizedBox(
                height: 50,
              ),
              ListTile(
                leading: Icon(LineIcons.user),
                title: Text(
                  'Name'.tr(),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  ub.name,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Divider(
                color: Colors.grey[500],
              ),
              ListTile(
                leading: Icon(LineIcons.envelope),
                title: Text(
                  'Email'.tr(),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  ub.email,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Divider(
                color: Colors.grey[500],
              ),
              ListTile(
                leading: Icon(LineIcons.calendar),
                title: Text(
                  'Member Since'.tr(),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  ub.joiningDate,
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ));
  }
}
