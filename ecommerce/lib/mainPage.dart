import 'package:ecommernce/core/widgets/custom_drawer.dart';
import 'package:ecommernce/features/products/presentation/pages/home_page.dart';
import 'package:ecommernce/features/purchase/presentation/pages/check_out_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class slMainPage extends StatelessWidget {
  CustomDrawerController drawerController;
  slMainPage(this.drawerController, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return sfMainPage(drawerController);
  }
}

class sfMainPage extends StatefulWidget {
  CustomDrawerController drawerController;
  sfMainPage(this.drawerController, {Key? key}) : super(key: key);
  @override
  State createState() => stateMainPage();
}

class stateMainPage extends State<sfMainPage> {
  int _selectedIndex = 1;
  static List<Widget> _widgetOptions = <Widget>[
    Container(),
    slhomePage(),
    CheckOutPage(),
    //slSettingsPage()
  ];

  void _onItemTapped(int index) {
    if (index == 0) {
      widget.drawerController.toggle();
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
              child: Center(
            child: _widgetOptions[_selectedIndex],
          )

              /* Container(
        child: Column(
          children: [
            Container(
              height: widgetHight,
              child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  switchInCurve: Curves.easeInCubic,
                  switchOutCurve: Curves.easeOutBack,
                  child: whichPage()),
            ),
            Container(
              color: Colors.blue,
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child:
                        iconWidget(0, Icons.home, s1, r1, cIcon1, cContainer1),
                  ),
                  Expanded(
                    child: iconWidget(1, Icons.shopping_cart_sharp, s2, r2,
                        cIcon2, cContainer2),
                  ),
                  Expanded(
                    child: iconWidget(
                        2, Icons.favorite, s3, r3, cIcon3, cContainer3),
                  ),
                ],
              ),
            )
          ],
        ),
      ),*/
              ),
          bottomNavigationBar: homePageTabBar()),
    );
  }

  BottomNavigationBar homePageTabBar() {
    return BottomNavigationBar(
      onTap: _onItemTapped,
      currentIndex: _selectedIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      //backgroundColor: bottomBarColor,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.menu,
            color: _selectedIndex == 0 ? Colors.red : Colors.blue,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: _selectedIndex == 1 ? Colors.red : Colors.blue,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.monetization_on,
            color: _selectedIndex == 2 ? Colors.red : Colors.blue,
          ),
          label: "",
        ),
      ],
    );
  }
}
