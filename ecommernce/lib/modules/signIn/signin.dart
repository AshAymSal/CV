import 'package:ecommernce/manegerMainPage.dart';
import 'package:ecommernce/modules/signIn/signInProvider.dart';
import 'package:ecommernce/modules/signUp/signup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ecommernce/cache/sharedPreferences.dart';

class signIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return signInState();
  }
}

class signInState extends State<signIn> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    email.text = sharedPreferences.getEmail();
    password.text = sharedPreferences.getPassword();
    /*String isLoged = sharedPreferences.getLogin();
    if (isLoged == "1") {
      
      String logpass = sharedPreferences.getPassword();
      signInProvider
          .getRead(context)
          .signIn(email: logemail.trim(), password: logpass.trim());
      */
  }

  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height;
    final totalWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
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
                  "Sign In",
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
                  obscureText: true,
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
                    "sign in",
                    style: TextStyle(fontSize: 17, fontFamily: "New"),
                  ),
                  onPressed: () {
                    signInProvider
                        .getRead(context)
                        .signIn(
                            email: email.text.trim(),
                            password: password.text.trim())
                        .then((value) {
                      Navigator.of(context).pop();
                    });
                  },
                ),
              ),
              SizedBox(
                height: totalHeight / 20,
              ),
              Container(
                width: totalWidth / 2.4,
                child: Row(
                  children: [
                    Text(
                      "Sign up here : ",
                      style: TextStyle(fontFamily: "New"),
                    ),
                    RichText(
                      text: TextSpan(
                          style:
                              TextStyle(color: Colors.blue, fontFamily: "New"),
                          text: "Sign Up",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return signUp();
                              }));
                            }),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: totalHeight / 3,
              ),
              Container(
                child: ElevatedButton(
                  child: Text(
                    "Maneger",
                    style: TextStyle(fontFamily: "New"),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return slManegerHome();
                    }));
                  },
                ),
              ),
            ],
          )),
    ));
  }
}
