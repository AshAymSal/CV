import 'package:flutter/material.dart';
import 'package:flutter_application_1/PrivateRounds.dart';
import 'package:flutter_application_1/constants.dart';

class HomePageMainGames extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageMainGamesState();
  }
}

class HomePageMainGamesState extends State {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Size.infinite.height,
      width: Size.infinite.width,
      color: backGroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text(
              "Hazzak Private Rounds",
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          SizedBox(height: 12),
          list1(),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 37,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PrivateRounds();
                    }));
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(fontSize: 13, color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      maximumSize: Size(100, 40),
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                ),
              ),
              Container(
                height: 37,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Create Round",
                    style: TextStyle(fontSize: 13, color: Colors.white),
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
            ],
          ),
          SizedBox(height: 30),
          Container(
              margin: EdgeInsets.only(left: 20),
              child:
                  Text("7 Day Lottery", style: TextStyle(color: Colors.white))),
          SizedBox(height: 12),
          list2(),
          SizedBox(height: 20),
          Row(
            children: [
              Spacer(),
              Text(
                "Next Drawing",
                style: TextStyle(fontSize: 15, color: Colors.yellow),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  Text(
                    "9 : 41",
                    style: TextStyle(fontSize: 28, color: Colors.white),
                  ),
                  Text(
                    "min       sec",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ],
              ),
              Spacer()
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 37,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Join Lottery",
                    style: TextStyle(fontSize: 13, color: Colors.white),
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
            ],
          ),
        ],
      ),
    );
  }
}

Widget list1() {
  return Container(
    width: Size.infinite.width,
    height: 150,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PrivateRounds();
              }));
            },
            child: Card(
              color: daysLotterColor,
              margin: EdgeInsets.only(right: 20, left: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 40,
                    width: 150,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text("Zomi Room",
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                  SizedBox(
                    height: 4,
                  ),
                  Text("46/100",
                      style: TextStyle(color: Colors.green, fontSize: 12)),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    height: 20,
                    width: 60,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Buy Ticket",
                        style: TextStyle(fontSize: 9, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          maximumSize: Size(100, 40),
                          primary: bottomBarColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text("Prize",
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                  SizedBox(
                    height: 4,
                  ),
                  Text("700 HZK",
                      style: TextStyle(color: Colors.yellow, fontSize: 12)),
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
    height: 154,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          return Card(
            color: Color(0xFF7d4eed),
            margin: EdgeInsets.only(right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("10M Lottery",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                        SizedBox(
                          height: 7,
                        ),
                        Text("Draw Look Price On",
                            style:
                                TextStyle(color: Colors.white70, fontSize: 8)),
                        SizedBox(
                          height: 7,
                        ),
                        Text("Mondey 12/12/2022",
                            style:
                                TextStyle(color: Colors.white, fontSize: 10)),
                        SizedBox(
                          height: 7,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Winning Numbers",
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        ),
                        SizedBox(height: 5),
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
                                color: Colors.yellowAccent,
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
                                color: Colors.yellowAccent,
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
                                color: Colors.yellowAccent,
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
                                color: Colors.yellowAccent,
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
                                color: Colors.yellowAccent,
                              ),
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        Text(
                          "The Price",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        Text(
                          "120 HZK",
                          style: TextStyle(color: Colors.yellow, fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
  );
}


/*
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
                            style:
                                TextStyle(color: Colors.white, fontSize: 13)),
                        Text("120M",
                            style:
                                TextStyle(color: Colors.yellow, fontSize: 15)),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    */