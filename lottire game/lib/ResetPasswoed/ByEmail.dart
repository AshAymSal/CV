import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';

class ByEmail extends StatefulWidget {
  const ByEmail({Key? key}) : super(key: key);

  @override
  State<ByEmail> createState() => _ByEmailState();
}

class _ByEmailState extends State<ByEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backGroundColor,
        //title: Text("Reset By"),
      ),
      body: Container(
        color: backGroundColor,
        height: Size.infinite.height,
        width: Size.infinite.width,
        child: Column(
          children: [
            Text(
              "Reset By Email",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              height: 270,
              width: Size.infinite.width,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 20),
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
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      height: 60,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: bottomBarColor,
                          width: 4,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                          style: TextStyle(fontSize: 14),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey),
                            hintText: "Email",
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.email),
                          ))),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 53,
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Send Request",
                        style: TextStyle(fontSize: 19, color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(mainAppBarColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ))),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
