import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';

class Wallet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WalletState();
  }
}

class WalletState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backGroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Container(
              height: 350,
              //width: Size.infinite.width,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: bottomBarColor,
                border: Border.all(
                  color: bottomBarColor,
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "WALLET  BALANCE",
                            style:
                                TextStyle(color: Colors.yellow, fontSize: 17),
                          ),
                          Text(
                            "1,300.00\$",
                            style:
                                TextStyle(color: Colors.yellow, fontSize: 45),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white60,
                          border: Border.all(
                            color: Colors.white12,
                            width: 4,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Text(
                          "3500 HZK",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 40,
                        width: 100,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Deposit",
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              maximumSize: Size(100, 40),
                              primary: Colors.pinkAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 100,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Withdraw",
                            style:
                                TextStyle(fontSize: 17, color: bottomBarColor),
                          ),
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              maximumSize: Size(100, 40),
                              primary: Colors.yellow,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "HZK Rate :",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        "1HZK=1USD",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 300,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: bottomBarColor,
                border: Border.all(
                  color: bottomBarColor,
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Container(height: 50, width: 50, color: Colors.red),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "BY WISH.MONEY",
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Requested Manually",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "02 Monday",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          )
                        ],
                      ),
                      Spacer(),
                      Text(
                        "12\$",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Container(height: 50, width: 50, color: Colors.yellow),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "BY WESTREN UNION",
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Requested Automatecally",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "02 Monday",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          )
                        ],
                      ),
                      Spacer(),
                      Text(
                        "17\$",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Container(height: 50, width: 50, color: Colors.green),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "BY USFT TRANSFER",
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Requested Manually",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "01 Sunday",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          )
                        ],
                      ),
                      Spacer(),
                      Text(
                        "20\$",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
