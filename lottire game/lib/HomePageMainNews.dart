import 'package:flutter/material.dart';
import 'package:flutter_application_1/PrivateRounds.dart';
import 'package:flutter_application_1/constants.dart';

class HomePageNews extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageNewsState();
  }
}

class HomePageNewsState extends State<HomePageNews> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Size.infinite.height,
      width: Size.infinite.width,
      color: backGroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            color: Colors.white,
            width: Size.infinite.width,
          ),
          SizedBox(height: 80),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text(
              "Top Winners Private Rounds",
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          SizedBox(height: 12),
          list1(),
          SizedBox(height: 50),
          Container(
              margin: EdgeInsets.only(left: 20),
              child:
                  Text("7 Day Lottery", style: TextStyle(color: Colors.white))),
          SizedBox(height: 12),
          list2()
        ],
      ),
    );
  }
}

Widget list1() {
  return Container(
    width: Size.infinite.width,
    height: 80,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(right: 20, left: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    height: 50,
                    width: 50,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text("Khaled Jad",
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                  SizedBox(
                    height: 2,
                  ),
                  Text("1440\$",
                      style: TextStyle(color: Colors.white, fontSize: 10))
                ],
              ),
            ),
          );
        }),
  );
}

Widget list2() {
  return Container(
    width: Size.infinite.width,
    height: 75,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          return Card(
            color: Color(0xFF7d4eed),
            margin: EdgeInsets.only(right: 20, left: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Winning Numbers",
                        style: TextStyle(color: Colors.white, fontSize: 10)),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "13",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff6628fa),
                          ),
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "32",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff6628fa),
                          ),
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "74",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff6628fa),
                          ),
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "46",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff6628fa),
                          ),
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "22",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff6628fa),
                          ),
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "12/12/2022",
                      style: TextStyle(color: Colors.white, fontSize: 8),
                      textAlign: TextAlign.left,
                    ),
                    Text("Draw 202",
                        style: TextStyle(color: Colors.white, fontSize: 9)),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Prize",
                        style: TextStyle(color: Colors.white, fontSize: 13)),
                    Text("120M",
                        style: TextStyle(color: Colors.yellow, fontSize: 15)),
                  ],
                ),
                SizedBox(
                  width: 20,
                )
              ],
            ),
          );
        }),
  );
}
