import 'package:apitest/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apitest/cache/AuthenticationProvider.dart';

import '../friend requests/freindRequestsProvider.dart';
import 'addFriendProvider.dart';

class addFriendScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => addFriendProvider(),
        child: Consumer<addFriendProvider>(builder: (context, modle, child) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      onChanged: (txt) {
                        if (txt.toString().length == 0) {
                          modle.clearSearch();
                        } else {
                          if (txt.toString().trim().length != 0) {
                            modle.getSearch(
                                authProvider.getRead(context).user!.id!, txt);
                          }
                        }
                      },
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.search),
                          border: InputBorder.none),
                    ),
                  ),
                  modle.isLoaded
                      ? modle.search.length > 0
                          ? Expanded(
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return friendWidgett(modle.search[index],
                                      modle.search[index].relative!);
                                },
                                itemCount: modle.search.length,
                              ),
                            )
                          : Expanded(
                              child: Center(
                              child: Text(
                                "No Matchs",
                                style: TextStyle(fontSize: 18),
                              ),
                            ))
                      : Expanded(
                          child: Center(
                          child: Text(
                            "Start Searching",
                            style: TextStyle(fontSize: 18),
                          ),
                        )),
                ]),
              ),
            ),
          );
        }));
  }
}

class friendWidgett extends StatefulWidget {
  userModel user;
  String status;
  friendWidgett(this.user, this.status, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return friendWidgetState(user, status);
  }
}

class friendWidgetState extends State<friendWidgett> {
  friendWidgetState(this.user, this.status);
  userModel user;
  String status;
  @override
  Widget build(BuildContext context) {
    // String status = user.relative!;
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
                    child: status == "stranger"
                        ? ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue)),
                            onPressed: () {
                              addFriendProvider
                                  .getRead(context)
                                  .sendRequest(
                                      context,
                                      authProvider.getRead(context).user!.id!,
                                      user.id!)
                                  .then((value) {
                                setState(() {
                                  status = "send";
                                });
                              });
                            },
                            child: Icon(Icons.add))
                        : status == "send"
                            ? ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.orange)),
                                onPressed: () {
                                  addFriendProvider
                                      .getRead(context)
                                      .cancelRequest(
                                          context,
                                          authProvider
                                              .getRead(context)
                                              .user!
                                              .id!,
                                          user.id!)
                                      .then((value) {
                                    setState(() {
                                      status = "stranger";
                                    });
                                  });
                                },
                                child: Icon(Icons.send))
                            : ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.green)),
                                onPressed: () {},
                                child: Icon(Icons.face))),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {}, child: Icon(Icons.message)),
                ),
                /*  SizedBox(
                width: 5,
              ),
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {}, child: Icon(Icons.delete))),*/
              ],
            )
          ]),
        ),
      ),
    );
  }
}
