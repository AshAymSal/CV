import 'package:apitest/modules/home/homeScreen.dart';
import 'package:apitest/modules/signup/signUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';
import '../../cache/AuthenticationProvider.dart';

class slSignInScreen extends StatelessWidget {
  const slSignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _sfSignInScreen();
  }
}

class _sfSignInScreen extends StatefulWidget {
  const _sfSignInScreen({Key? key}) : super(key: key);

  @override
  createState() => _stateSignInScreen();
}

class _stateSignInScreen extends State<_sfSignInScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  var fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var totalheight = MediaQuery.of(context).size.height;
    var totalwidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Form(
            key: fromKey,
            child: Container(
              color: Color(0xFFff5d52),
              child: Column(
                children: [
                  SizedBox(
                    height: totalheight / 6,
                  ),
                  signInTextField(totalwidth / 10, totalwidth / 30,
                      type: "User Name"),
                  SizedBox(
                    height: totalheight / 20,
                  ),
                  signInTextField(totalwidth / 10, totalwidth / 30,
                      type: "Password"),
                  SizedBox(
                    height: totalheight / 15,
                  ),
                  Container(
                      width: totalwidth / 4,
                      height: totalheight / 17,
                      child: signButton(
                          text: "Sign In",
                          f: () {
                            final isValid = fromKey.currentState?.validate();
                            if (isValid!) {
                              authProvider
                                  .getRead(context)
                                  .signIn(username.text, password.text);
                            }
                          })),
                  SizedBox(
                    height: totalheight / 20,
                  ),
                  Container(
                      width: totalwidth / 4,
                      height: totalheight / 17,
                      child: signButton(
                          text: "Sign Up",
                          f: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return slSignUpScreen();
                            }));
                          }))
                ],
              ),
            )));
  }

  Widget signInTextField(double margin, double padding,
      {required String type}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.symmetric(horizontal: margin),
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: TextFormField(
        controller: type == "User Name" ? username : password,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: type,
        ),
        validator: (value) {
          return value!.length == 0 ? "no" : null;
        },
      ),
    );
  }
}

Widget signButton({required String text, required Function() f}) {
  return ElevatedButton(
    onPressed: f,
    child: Text(
      text,
      style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: "New"),
    ),
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ))),
  );
}
