import 'package:apitest/modules/home/drawer/friend%20requests/friendRequestsScreen.dart';
import 'package:apitest/modules/messeges/messagesScreen.dart';
import 'package:apitest/modules/notifications/notificationsProvider.dart';
import 'package:apitest/modules/posts/postsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../cache/AuthenticationProvider.dart';
import '../notifications/notificationsScreen.dart';
import 'drawer/drawerWidget.dart';
import 'drawer/friends/friendsProvider.dart';

class slhomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (BuildContext context) => notificationsProvider()
          ..getAllNotificaions(
              authProvider.getRead(context).user!.id!.toString()),
      ),
    ], child: _sfhomeSecreen());
  }
}

class _sfhomeSecreen extends StatefulWidget {
  _sfhomeSecreen({Key? key}) : super(key: key);

  @override
  State createState() => _statehomeSecreen();
}

class _statehomeSecreen extends State<_sfhomeSecreen>
    with SingleTickerProviderStateMixin {
  late TabController con;

  @override
  void initState() {
    super.initState();
    FriendsProvider.getRead(context)
        .getFriends(authProvider.getRead(context).user!.id!);
    con = TabController(length: 3, vsync: this);
    con.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    con.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var totalheight = MediaQuery.of(context).size.height;
    var totalwidth = MediaQuery.of(context).size.width;

    return Consumer<notificationsProvider>(builder: (context, modle, child) {
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            bottom: TabBar(
              controller: con,
              tabs: [
                Tab(
                  icon: Icon(Icons.message),
                ),
                Tab(
                  icon: Icon(Icons.home),
                ),
                Tab(
                  icon: Stack(children: [
                    Container(
                        height: 30,
                        width: 30,
                        child: Icon(Icons.notifications)),
                    modle.allNotifications.length != 0
                        ? Container(
                            alignment: Alignment.center,
                            child: Text(
                              "${modle.n}",
                              style: TextStyle(fontSize: 13),
                            ),
                            height: 17,
                            width: 17,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                          )
                        : Container(
                            width: 1,
                            height: 1,
                          )
                  ]),
                ),
              ],
            ),
          ),
          drawer: drawerWidget(),
          body: TabBarView(
            controller: con,
            children: [
              Center(
                child: slMessagesSecreen(),
              ),
              Center(
                child: slPostsSecreen(),
              ),
              Center(
                child: slNotificationsSecreen(),
              ),
            ],
          ),
        ),
      );
    });
  }
}
