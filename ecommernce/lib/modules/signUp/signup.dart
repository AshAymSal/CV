import 'package:ecommernce/modules/signIn/signInProvider.dart';
import 'package:flutter/material.dart';

class signUp extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height;
    final totalWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          height: totalHeight,
          width: totalWidth,
          color: Color(0xffd3faff),
          child: Column(
            children: [
              SizedBox(
                height: totalHeight / 6,
              ),
              Container(
                child: Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 25, fontFamily: "New"),
                ),
              ),
              SizedBox(
                height: totalHeight / 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: totalWidth / 30),
                color: Colors.white,
                width: totalWidth / 1.2,
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: totalHeight / 30,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: totalWidth / 30),
                color: Colors.white,
                width: totalWidth / 1.2,
                child: TextField(
                  controller: password,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: totalHeight / 20,
              ),
              Container(
                width: totalWidth / 3,
                height: totalHeight / 20,
                child: ElevatedButton(
                  child: Text(
                    "sign up",
                    style: TextStyle(fontSize: 15, fontFamily: "New"),
                  ),
                  onPressed: () {
                    signInProvider.getRead(context).signUp(
                        email: email.text.trim(),
                        password: password.text.trim());
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          )),
    );
  }
}
