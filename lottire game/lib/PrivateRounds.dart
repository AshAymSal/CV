import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';

class PrivateRounds extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PrivateRoundsState();
  }
}

class PrivateRoundsState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backGroundColor,
        title: Text("Private Rounds"),
      ),
      body: Container(
        color: backGroundColor,
        child: Column(
          children: [
            Row(
              children: [
                Spacer(),
                Container(
                  height: 65,
                  width: 60,
                  //color: Colors.white,
                  child: Column(
                    children: [
                      Text(
                        "Filter",
                        style: TextStyle(color: Colors.white),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.filter_frames,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 30,
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                //Spacer(),
                Expanded(flex: 2, child: Container()),
                Expanded(
                  child: Container(
                    child: Text(
                      "Name",
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                ),
                //Spacer(),
                Expanded(
                  child: Container(
                    child: Text(
                      "Prize",
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                ),
                //Spacer(),
                Expanded(
                  child: Container(
                    child: Text(
                      "Ticket Cost",
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                ),
                //Spacer(),
                Expanded(
                  child: Container(
                    child: Text(
                      "Available",
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                ),
                //Spacer(),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            /* Container(
              height: 450,
              width: Size.infinite.width,
              color: Colors.red,
            ),*/
            list1(),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Spacer(),
                Container(
                  height: 70,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Create Round",
                      style: TextStyle(fontSize: 18, color: Colors.yellow),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(bottomBarColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ))),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  height: 70,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "My tickets",
                      style: TextStyle(fontSize: 18, color: Color(0xff2000d6)),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ))),
                  ),
                ),
                Spacer()
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget list1() {
  return Container(
    width: Size.infinite.width,
    height: 450,
    child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 20),
            child: GestureDetector(
              onTap: () {
                /*Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PrivateRounds();
                }));*/
              },
              child: Container(
                //margin: EdgeInsets.symmetric(horizontal: 30),
                height: 100,
                child: Row(
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          border: Border(
                            right: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                          //  borderRadius: BorderRadius.circular(0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 30,
                              width: 90,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  "Share",
                                  style: TextStyle(
                                      fontSize: 11, color: Color(0xff2000d6)),
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ))),
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              height: 30,
                              width: 90,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  "Buy Ticket",
                                  style: TextStyle(
                                      fontSize: 11, color: Color(0xff2000d6)),
                                ),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.yellow),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //Spacer(),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          border: Border(
                            right: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                          //  borderRadius: BorderRadius.circular(0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Tammam",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white)),
                            SizedBox(height: 3),
                            Text("ID : 003255",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    //Spacer(),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        height: Size.infinite.height,
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          border: Border(
                            right: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                          //  borderRadius: BorderRadius.circular(0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "7000",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.yellow),
                            ),
                            Text(
                              "HZK",
                              style:
                                  TextStyle(fontSize: 13, color: Colors.yellow),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //Spacer(),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        height: Size.infinite.height,
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          border: Border(
                            right: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                          //  borderRadius: BorderRadius.circular(0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "50",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                            ),
                            Text(
                              "HZK",
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //Spacer(),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Spacer(),
                            Row(
                              children: [
                                SizedBox(width: 10),
                                Text(
                                  "500",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                              ],
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "460",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.green),
                                ),
                                SizedBox(width: 10),
                              ],
                            ),
                            Spacer()
                          ],
                        ),
                      ),
                    ),
                    //Spacer(),
                  ],
                ),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                    bottom: BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  //  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ),
          );
        }),
  );
}
