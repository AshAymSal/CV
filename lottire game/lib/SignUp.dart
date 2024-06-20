import 'package:flutter/material.dart';
import 'package:flutter_application_1/SignIn.dart';
import 'package:flutter_application_1/constants.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isPassObscure = true;
  bool isRePassObscure = true;
  bool isAccept = false;
  Icon acceptTrue = Icon(
    Icons.check_box,
    color: Colors.white,
    size: 25,
  );
  Icon acceptFalse = Icon(
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
            "Sign Up Account",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 620,
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
                          hintText: "First Name",
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
                        style: TextStyle(fontSize: 14),
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: "Last Name",
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.person),
                        ))),
                SizedBox(height: 7),
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
                          prefixIcon: Icon(Icons.contact_phone),
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
                        obscureText: isPassObscure,
                        style: TextStyle(fontSize: 14),
                        maxLines: 1,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey),
                            hintText: "Password",
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: isPassObscure ? obscureTrue : obscureFalse,
                              onPressed: () {
                                setState(() {
                                  isPassObscure = !isPassObscure;
                                });
                              },
                            )))),
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
                        obscureText: isRePassObscure,
                        style: TextStyle(fontSize: 14),
                        maxLines: 1,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey),
                            hintText: "Re-Password",
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon:
                                  isRePassObscure ? obscureTrue : obscureFalse,
                              onPressed: () {
                                setState(() {
                                  isRePassObscure = !isRePassObscure;
                                });
                              },
                            )))),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isAccept = !isAccept;
                        });
                      },
                      child: isAccept ? acceptTrue : acceptFalse,
                    ),
                    SizedBox(width: 5),
                    Text("I Accept The Terms And Conditions",
                        style: TextStyle(color: Colors.white, fontSize: 12)),
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
                      "Sign Up",
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
                      "If You Have Account : ",
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SignIn();
                        }));
                      },
                      child: Text(
                        "Sign In",
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
