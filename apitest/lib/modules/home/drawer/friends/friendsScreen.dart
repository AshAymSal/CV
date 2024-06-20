import 'dart:async';

import 'package:apitest/models/user.dart';
import 'package:apitest/modules/home/drawer/friends/friendsProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:apitest/cache/AuthenticationProvider.dart';
import 'package:provider/provider.dart';
import 'addFriendScreen.dart';

class FriendsScreen extends StatelessWidget {
  FriendsScreen({Key? key}) : super(key: key);
  //List friends;
  StreamController _streamController = StreamController();
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    //List friends = FriendsProvider.getWatch(context).friends;
    /* return ChangeNotifierProvider(
        create: (BuildContext context) => FriendsProvider()
          ..getFriends(authProvider.getRead(context).user!.id!.toString()),
        child: Consumer<FriendsProvider>(builder: (context, modle, child) {}));*/
    return Consumer<FriendsProvider>(builder: (context, modle, child) {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return addFriendScreen();
              }));
            },
          ),
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return friendWidget(context, modle.friends[index]);
              },
              itemCount: modle.friends.length,
            ),
          ));
    });
  }
}

/*
body: !modle.isLoaded
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return friendWidget(context, modle.friends[index]);
                        },
                        itemCount: modle.friends.length,
                      ),
                    )
                    */

Widget friendWidget(BuildContext context, userModel user) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8)),
    margin: EdgeInsets.only(top: 7),
    child: Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                color: Colors.red,
              ),
              SizedBox(
                width: 30,
              ),
              Text(
                "${user.name}",
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: () {}, child: Icon(Icons.message)),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        FriendsProvider.getRead(context).deleteFriend(context,
                            authProvider.getRead(context).user!.id!, user.id!);
                      },
                      child: Icon(Icons.delete))),
            ],
          )
        ]),
      ),
    ),
  );
}
