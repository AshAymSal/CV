import 'package:apitest/modules/home/homeScreen.dart';
import 'package:apitest/cache/AuthenticationRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';
import '../../cache/AuthenticationProvider.dart';

class slSignUpScreen extends StatelessWidget {
  const slSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _sfSignUpScreen();
  }
}

class _sfSignUpScreen extends StatefulWidget {
  const _sfSignUpScreen({Key? key}) : super(key: key);

  @override
  createState() => _stateSignUpScreen();
}

class _stateSignUpScreen extends State<_sfSignUpScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var totalheight = MediaQuery.of(context).size.height;
    var totalwidth = MediaQuery.of(context).size.width;

    return Container(
      color: Color(0xFFff5d52),
      child: Column(
        children: [
          SizedBox(
            height: totalheight / 6,
          ),
          signUpTextField(totalwidth / 10, totalwidth / 30, type: "User Name"),
          SizedBox(
            height: totalheight / 20,
          ),
          signUpTextField(totalwidth / 10, totalwidth / 30, type: "Password"),
          SizedBox(
            height: totalheight / 15,
          ),
          Container(
              width: totalwidth / 4,
              height: totalheight / 17,
              child: signUpButton()),
        ],
      ),
    );
  }

  Widget signUpTextField(double margin, double padding,
      {required String type}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.symmetric(horizontal: margin),
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: TextField(
        controller: type == "User Name" ? username : password,
        decoration: InputDecoration(border: InputBorder.none, labelText: type),
      ),
    );
  }

  Widget signUpButton() {
    return ElevatedButton(
      onPressed: () async {
        String register = await myRepo().signUp(username.text, password.text);
        if (register == "Done") {
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("User Exists")));
        }
      },
      child: Text(
        "Sign Up",
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
}
