import 'package:flutter/material.dart';
import 'package:flutter_application_1/ResetPasswoed/ResetPasswordBy.dart';
import 'package:flutter_application_1/SignUp.dart';
import 'package:flutter_application_1/constants.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isObscure = true;
  bool isRemember = false;
  Icon rememberTrue = Icon(
    Icons.check_box,
    color: Colors.white,
    size: 25,
  );
  Icon rememberFalse = Icon(
    Icons.check_box_outline_blank,
    color: Colors.white,
    size: 25,
  );
  Icon obscureTrue = Icon(
    Icons.remove_red_eye_outlined,
    //color: Colors.white,
    size: 19,
  );
  Icon obscureFalse = Icon(
    Icons.panorama_fish_eye_rounded,
    //color: Colors.white,
    size: 19,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: backGroundColor,
          automaticallyImplyLeading: false),
      body: Container(
        width: Size.infinite.width,
        height: Size.infinite.height,
        color: backGroundColor,
        child: Column(children: [
          Text(
            "Sign In Account",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(
            height: 70,
          ),
          Container(
            height: 440,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
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
                          hintText: "Mobile or Email",
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.person),
                        ))),
                SizedBox(
                  height: 7,
                ),
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
                        obscureText: isObscure,
                        style: TextStyle(fontSize: 14),
                        maxLines: 1,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey),
                            hintText: "*****",
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: isObscure ? obscureTrue : obscureFalse,
                              onPressed: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              },
                            )))),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isRemember = !isRemember;
                        });
                      },
                      child: isRemember ? rememberTrue : rememberFalse,
                    ),
                    SizedBox(width: 5),
                    Text("Remember Me",
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ResetPasswordBy();
                        }));
                      },
                      child: Text("Forgot Password?",
                          style: TextStyle(color: Colors.white, fontSize: 12)),
                    )
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
                Container(
                  height: 53,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Sign In",
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
                SizedBox(
                  height: 90,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "If You Have No Account : ",
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SignUp();
                        }));
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
