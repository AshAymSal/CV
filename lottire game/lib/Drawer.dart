import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';

Widget drawer() {
  final padding = EdgeInsets.symmetric(horizontal: 10);
  return Drawer(
      child: Material(
    color: bottomBarColor,
    child: ListView(
      padding: padding,
      children: [
        SizedBox(height: 30),
        Container(
          height: 130,
          width: 50,
          // color: Colors.cyan,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff6628fa),
                ),
                height: 80,
                width: 80,
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Marcos Tomas",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  Text("demo@gmail.com",
                      style: TextStyle(fontSize: 10, color: Colors.white))
                ],
              )
            ],
          ),
        ),
        ListTile(
          title: Text(
            "My Profile",
            style: TextStyle(color: Colors.white),
          ),
          leading: Icon(
            Icons.person_outlined,
            color: Colors.white,
          ),
          onTap: () {
            /* Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return sldemo2();
            }));*/
          },
        ),
        SizedBox(height: 0),
        ListTile(
          title: Text(
            "Private Room",
            style: TextStyle(color: Colors.white),
          ),
          leading: Icon(
            Icons.room,
            color: Colors.white,
          ),
          onTap: () {},
        ),
        SizedBox(height: 0),
        ListTile(
          title: Text(
            "Hazzak Lottery",
            style: TextStyle(color: Colors.white),
          ),
          leading: Icon(
            Icons.games,
            color: Colors.white,
          ),
          onTap: () {},
        ),
        SizedBox(height: 0),
        ListTile(
          title: Text(
            "Wallet",
            style: TextStyle(color: Colors.white),
          ),
          leading: Icon(
            Icons.wallet_giftcard,
            color: Colors.white,
          ),
          onTap: () {},
        ),
        Divider(
          color: Colors.white54,
        ),
        SizedBox(height: 0),
        ListTile(
          title: Text(
            "Privecy & Ploicy",
            style: TextStyle(color: Colors.white),
          ),
          leading: Icon(
            Icons.privacy_tip,
            color: Colors.white,
          ),
          onTap: () {},
        ),
        SizedBox(height: 0),
        ListTile(
          title: Text(
            "Term & Conditions",
            style: TextStyle(color: Colors.white),
          ),
          leading: Icon(
            Icons.privacy_tip,
            color: Colors.white,
          ),
          onTap: () {},
        ),
        Divider(
          color: Colors.white54,
        ),
        SizedBox(height: 0),
        ListTile(
          title: Text(
            "Help & Support",
            style: TextStyle(color: Colors.white),
          ),
          leading: Icon(
            Icons.support,
            color: Colors.white,
          ),
          onTap: () {},
        ),
        SizedBox(height: 0),
        ListTile(
          title: Text(
            "Q & A",
            style: TextStyle(color: Colors.white),
          ),
          leading: Icon(
            Icons.question_answer,
            color: Colors.white,
          ),
          onTap: () {},
        ),
        SizedBox(height: 0),
        ListTile(
          title: Text(
            "Referral Link",
            style: TextStyle(color: Colors.white),
          ),
          leading: Icon(
            Icons.link,
            color: Colors.white,
          ),
          onTap: () {},
        ),
        SizedBox(height: 0),
        ListTile(
          title: Text(
            "Settings",
            style: TextStyle(color: Colors.white),
          ),
          leading: Icon(
            Icons.settings,
            color: Colors.white,
          ),
          onTap: () {},
        ),
        SizedBox(height: 0),
        ListTile(
          title: Text(
            "Log out",
            style: TextStyle(color: Colors.white),
          ),
          leading: Icon(
            Icons.logout,
            color: Colors.white,
          ),
          onTap: () {},
        ),
      ],
    ),
  ));
}
