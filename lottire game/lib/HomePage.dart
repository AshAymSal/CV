import 'package:flutter/material.dart';
import 'package:flutter_application_1/Drawer.dart';
import 'package:flutter_application_1/HomePageMain.dart';
import 'package:flutter_application_1/HomePageMainNews.dart';
import 'package:flutter_application_1/Wallet.dart';
import 'package:flutter_application_1/constants.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  static List<Widget> _widgetOptions = <Widget>[
    Container(),
    HomePageMain(),
    Wallet()
  ];

  void _onItemTapped(int index) {
    if (index == 0) {
      _scaffoldKey.currentState?.openDrawer();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(35.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: daysLotterColor,
            automaticallyImplyLeading: false,
            title: customTitle(),
          ),
        ),
        body: Center(
          child: _widgetOptions[_selectedIndex],
        ),
        bottomNavigationBar: homePageTabBar(),
        drawer: drawer(),
      ),
    );
  }

  BottomNavigationBar homePageTabBar() {
    return BottomNavigationBar(
      onTap: _onItemTapped,
      currentIndex: _selectedIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: bottomBarColor,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.white,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.wallet_membership,
            color: Colors.white,
          ),
          label: "",
        ),
      ],
    );
  }
}

Widget customTitle() {
  return Container(
    height: 70,
    child: Row(children: [
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "balance",
            style: TextStyle(fontSize: 10),
          ),
          Text(
            "28.000 HZK",
            style: TextStyle(fontSize: 10),
          )
        ],
      ),
      SizedBox(width: 30),
      //Spacer(),
      Container(
        height: 17,
        width: 50,
        child: ElevatedButton(
          onPressed: () {},
          child: Text(
            "Deposit",
            style: TextStyle(fontSize: 9, color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              maximumSize: Size(100, 40),
              primary: Colors.pinkAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              )),
        ),
      ),
      Spacer(),
      Container(
        height: 17,
        width: 50,
        child: ElevatedButton(
          onPressed: () {},
          child: Text(
            "Log out",
            style: TextStyle(fontSize: 9, color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              maximumSize: Size(100, 40),
              primary: Colors.pinkAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              )),
        ),
      ),
      SizedBox(width: 15),
      GestureDetector(
        child: Icon(
          Icons.flag_sharp,
          size: 23,
        ),
        onTap: () {},
      ),
      SizedBox(width: 10),
      GestureDetector(
        child: Icon(
          Icons.notification_add_rounded,
          size: 23,
        ),
        onTap: () {},
      ),
    ]),
  );
}




/*
TabBar(tabs: [
    Tab(child: Icon(Icons.menu)),
    Tab(
      child: Text(
        "Home",
        style: TextStyle(fontSize: 25),
      ),
    ),
    Tab(
      child: Text(
        "Wallet",
        style: TextStyle(fontSize: 25),
      ),
    ),
  ]);
  */