import 'package:apitest/cache/AuthenticationProvider.dart';
import 'package:apitest/modules/home/drawer/friends/friendsProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'friend requests/freindRequestsProvider.dart';
import 'friend requests/friendRequestsScreen.dart';
import 'friends/friendsScreen.dart';

class drawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    friendRequestsProvider
        .getRead(context)
        .getAllRequests(authProvider.getRead(context).user!.id!);
    return draweWidgett();
  }
}

class draweWidgett extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var modle = friendRequestsProvider.getWatch(context);

    return Drawer(
      child: Material(
          child: ListView(
        children: [
          ListTile(
            title: Row(
              children: [
                Container(
                  color: Colors.red,
                  height: 60,
                  width: 60,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  authProvider.getRead(context).user!.name!,
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.black,
            thickness: 1,
          ),
          GestureDetector(
            onTap: () {
              var modle = FriendsProvider.getRead(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FriendsScreen();
              }));
            },
            child: ListTile(
              title: Text(
                "Friends",
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FriendsRequestsScreen();
              }));
            },
            child: ListTile(
              title: Row(
                children: [
                  Text(
                    "Friend Requests",
                    style: TextStyle(fontSize: 15),
                  ),
                  Container(child: Spacer()),
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.blue),
                    child: Text(
                      modle.allRequests.length.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.black,
            thickness: 1,
          ),
          ListTile(
            title: GestureDetector(
              onTap: () {
                print(FriendsProvider.getRead(context).friends.length);
              },
              child: Text("test", style: TextStyle(fontSize: 15)),
            ),
          ),
          Divider(
            color: Colors.black,
            thickness: 1,
          ),
          ListTile(
            title: GestureDetector(
              onTap: () {
                authProvider.getRead(context).signOut();
              },
              child: Text("Sign out", style: TextStyle(fontSize: 15)),
            ),
          )
        ],
      )),
    );
  }
}
