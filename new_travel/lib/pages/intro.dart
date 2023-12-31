import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:new_travel/utils/next_screen.dart';
import 'package:new_travel/widgets/navbar.dart';
import 'package:easy_localization/easy_localization.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            height: h * 0.80,
            child: Carousel(
              dotVerticalPadding: h * 0.00,
              dotColor: Colors.grey,
              dotIncreasedColor: Colors.blueAccent,
              autoplay: false,
              dotBgColor: Colors.transparent,
              dotSize: 6,
              dotSpacing: 15,
              images: [page1(), page2(), page3()],
            ),
          ),
          SizedBox(
            height: h * 0.05,
          ),
          Container(
            height: 45,
            width: w * 0.70,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(25),
            ),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: Text(
                'Get Started'.tr(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                nextScreenReplace(context, NavBar());
              },
            ),
          ),
          SizedBox(
            height: 0.15,
          ),
        ],
      ),
    );
  }

  Widget page1() {
    double h = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Container(
            alignment: Alignment.center,
            height: h * 0.38,
            child: Image(
              image: AssetImage('assets/images/travel6.png'),
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Text(
              'No Matter Where You Are'.tr(),
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8, bottom: 8),
            height: 3,
            width: 150,
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(40)),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              'Access to importent infoemation about your destination before and during your travel...'
                  .tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }

  Widget page2() {
    double h = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Container(
            alignment: Alignment.center,
            height: h * 0.38,
            child: Image(
              image: AssetImage('assets/images/travel1.png'),
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Text(
              'Explore Nearby Stuffs'.tr(),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8, bottom: 8),
            height: 3,
            width: 150,
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(40)),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              'Explore nearby hotels & retaurants near every tourist spots with the most most easiest way...'
                  .tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }

  Widget page3() {
    double h = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Container(
            alignment: Alignment.center,
            height: h * 0.38,
            child: Image(
              image: AssetImage('assets/images/travel5.png'),
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Text(
              'Realtime Travel Guide'.tr(),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8, bottom: 8),
            height: 3,
            width: 150,
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(40)),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              'Get directions, costs and other travel related stuffs in one place....'
                  .tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }
}
