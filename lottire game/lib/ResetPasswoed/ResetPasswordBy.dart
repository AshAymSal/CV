import 'package:flutter/material.dart';
import 'package:flutter_application_1/ResetPasswoed/ByEmail.dart';
import 'package:flutter_application_1/ResetPasswoed/ByPhone.dart';
import 'package:flutter_application_1/constants.dart';

class ResetPasswordBy extends StatefulWidget {
  const ResetPasswordBy({Key? key}) : super(key: key);

  @override
  State<ResetPasswordBy> createState() => _ResetPasswordByState();
}

class _ResetPasswordByState extends State<ResetPasswordBy> {
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
              "Reset By",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(
              height: 70,
            ),
            Container(
              height: 300,
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ByEmail();
                      }));
                    },
                    child: Text(
                      "Reset By Email",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                  SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ByPhone();
                      }));
                    },
                    child: Text(
                      "Reset By Phone",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                  SizedBox(height: 80),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "If You Have No Account Sign Up ",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  // SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
