import 'package:flutter/material.dart';
import 'package:flutter_application_1/HomePageMainGames.dart';
import 'package:flutter_application_1/HomePageMainNews.dart';

class HomePageMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageMainState();
  }
}

class HomePageMainState extends State {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Color(0xff8b00d6),
              automaticallyImplyLeading: false,
              title: homePageMainTabBar()),
          body: TabBarView(
            children: [
              HomePageNews(),
              HomePageMainGames(),
            ],
          ),
        ));
  }
}

TabBar homePageMainTabBar() {
  return TabBar(
    indicatorColor: Colors.white,
    tabs: [
      Tab(
        child: Text(
          "News",
          style: TextStyle(fontSize: 25),
        ),
      ),
      Tab(
        child: Text(
          "Games",
          style: TextStyle(fontSize: 25),
        ),
      ),
    ],
  );
}
