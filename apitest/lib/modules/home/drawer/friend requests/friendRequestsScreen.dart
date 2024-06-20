import 'dart:async';

import 'package:apitest/cache/AuthenticationProvider.dart';
import 'package:apitest/modules/home/drawer/friends/friendsProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'freindRequestsProvider.dart';

class FriendsRequestsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return friendsRequestsScreenState();
  }
}

class friendsRequestsScreenState extends State<FriendsRequestsScreen> {
  StreamController _streamController = StreamController();
  late Timer _timer;

  @override
  void initState() {
    //Check the server every 5 seconds
    _timer = Timer.periodic(
        Duration(seconds: 5),
        (timer) => friendRequestsProvider
                .getRead(context)
                .getAllRequests(authProvider.getRead(context).user!.id!)
                .then((value) {
              _streamController.add(value);
            }));

    super.initState();
  }

  @override
  void dispose() {
    //cancel the timer
    if (_timer.isActive) _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var modle = friendRequestsProvider.getWatch(context);
    return Scaffold(
        appBar: AppBar(),
        body: StreamBuilder(
            stream: _streamController.stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData)
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemBuilder: (context, index) {
                        return friendsRequestsWidget(context,
                            whom: modle.allRequests[index]);
                      },
                      itemCount: modle.allRequests.length),
                );
              return Center(child: CircularProgressIndicator());
            })

        /*!modle.isLoaded
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return friendsRequestsWidget(context,
                        whom: modle.allRequests[index]);
                  },
                  itemCount: modle.allRequests.length),
            ),*/
        );
  }
}

Widget friendsRequestsWidget(BuildContext context, {required String whom}) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(8)),
    margin: EdgeInsets.only(top: 10),
    child: ListTile(
      title: Text(
        "$whom",
        style: TextStyle(fontSize: 20),
      ),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        IconButton(
          icon: Icon(Icons.done),
          onPressed: () {
            friendRequestsProvider.getRead(context).AcceptRequest(
                context, authProvider.getRead(context).user!.id!, whom);
            FriendsProvider.getRead(context)
                .getFriends(authProvider.getRead(context).user!.id!);
          },
        ),
        IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            friendRequestsProvider.getRead(context).DenyRequest(
                context, authProvider.getRead(context).user!.id!, whom);
          },
        )
      ]),
    ),
  );
}
