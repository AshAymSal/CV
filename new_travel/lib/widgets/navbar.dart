import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';

import 'package:new_travel/pages/blog.dart';
import 'package:new_travel/pages/bookmark.dart';
import 'package:new_travel/pages/home.dart';
import 'package:new_travel/pages/profile.dart';
import 'package:new_travel/pages/settings.dart';

import 'package:easy_localization/easy_localization.dart';

class NavBar extends StatefulWidget {
  NavBar({Key? key}) : super(key: key);

  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  Widget page = HomePage();
  int currentIndex = 0;

  whenBackButtonClicked() {
    if (currentIndex == 0) {
      SystemNavigator.pop();
    } else {
      setState(() {
        currentIndex = 0;
        page = HomePage();
      });
    }
  }

  Widget customNavBar() {
    return Container(
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(color: Colors.black12, blurRadius: 10)
      ]),
      child: BottomNavyBar(
        selectedIndex: currentIndex,
        showElevation: true,
        itemCornerRadius: 25,
        onItemSelected: (index) => setState(() {
          currentIndex = index;
          if (index == 0) {
            page = HomePage();
          } else if (index == 1) {
            page = BlogPage();
          } else if (index == 2) {
            page = BookmarkPage();
          } else if (index == 3) {
            page = ProfilePage();
          } else if (index == 4) {
            page = SettingsPage();
          }
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.explore),
            title: Text('Explore').tr(),
            activeColor: Colors.grey, //Colors.grey[900],
            inactiveColor: Colors.grey[500],
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.camera),
            title: Text('Blog').tr(),
            activeColor: Colors.grey, //Colors.grey[900],
            inactiveColor: Colors.grey[500],
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.bookmark_border),
            title: Text(
              'Bookmark',
            ).tr(),
            activeColor: Colors.grey, // Colors.grey[900],
            inactiveColor: Colors.grey[500],
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(LineIcons.user),
            title: Text('Profile').tr(),
            activeColor: Colors.grey, //Colors.grey[900],
            inactiveColor: Colors.grey[500],
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings').tr(),
            activeColor: Colors.grey, //Colors.grey[900],
            inactiveColor: Colors.grey[500],
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return whenBackButtonClicked();
      },
      child: Scaffold(bottomNavigationBar: customNavBar(), body: page),
    );
  }
}
