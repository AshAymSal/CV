import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:new_travel/blocs/internet_bloc.dart';
import 'package:new_travel/blocs/sign_in_bloc.dart';
import 'package:new_travel/models/config.dart';
import 'package:new_travel/pages/success.dart';
import 'package:new_travel/utils/next_screen.dart';
import 'package:new_travel/utils/snacbar.dart';
import 'package:new_travel/utils/toast.dart';
import 'package:new_travel/widgets/loading_signin_ui.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:the_apple_sign_in/the_apple_sign_in.dart';

import 'dart:io';

class WellComePage extends StatefulWidget {
  WellComePage({Key? key, this.isSkip}) : super(key: key);
  final bool? isSkip;

  _WellComePageState createState() => _WellComePageState();
}

class _WellComePageState extends State<WellComePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool signInStart = false;
  String? brandName;
  bool supportsAppleSignIn = false;

  void handleFacebbokLogin() async {
    final SignInBloc sb = Provider.of<SignInBloc>(context, listen: false);
    final InternetBloc ib = Provider.of<InternetBloc>(context, listen: false);
    await ib.checkInternet();
    if (ib.hasInternet == false) {
      //openSnacbar(_scaffoldKey, 'No internet available');
      openSnacbar(context, 'No internet available');
      openToast1(context, 'No internet available'.tr());
    } else {
      setState(() {
        signInStart = true;
        brandName = 'Facebook';
      });

      await sb.logInwithFacebook().then((_) {
        if (sb.hasError == true) {
          openToast1(context,
              'Error with facebook login! Please try with Google'.tr());
          setState(() {
            signInStart = false;
          });
        } else {
          sb.checkUserExists().then((value) {
            if (sb.userExists == true) {
              sb.getUserData(sb.uid).then((value) => sb.saveDataToSP().then(
                  (value) => sb.setSignIn().then(
                      (value) => nextScreenReplace(context, SuccessPage()))));
            } else {
              sb.getJoiningDate().then((value) => sb.saveDataToSP().then(
                  (value) => sb.saveToFirebase().then((value) => sb
                      .setSignIn()
                      .then((value) =>
                          nextScreenReplace(context, SuccessPage())))));
            }
          });
        }
      });
    }
  }

  void handleGoogleLogin() async {
    final SignInBloc sb = Provider.of<SignInBloc>(context);
    final InternetBloc ib = Provider.of<InternetBloc>(context);
    await ib.checkInternet();
    if (ib.hasInternet == false) {
      openSnacbar(_scaffoldKey, 'No internet available');
      openToast1(context, 'No internet available'.tr());
    } else {
      setState(() {
        signInStart = true;
        brandName = 'Google';
      });

      await sb.signInWithGoogle().then((_) {
        if (sb.hasError == true) {
          openToast1(context, 'Something is wrong. Please try again.'.tr());
          setState(() {
            signInStart = false;
          });
        } else {
          sb.checkUserExists().then((value) {
            if (sb.userExists == true) {
              sb.getUserData(sb.uid).then((value) => sb.saveDataToSP().then(
                  (value) => sb.setSignIn().then(
                      (value) => nextScreenReplace(context, SuccessPage()))));
            } else {
              sb.getJoiningDate().then((value) => sb.saveDataToSP().then(
                  (value) => sb.saveToFirebase().then((value) => sb
                      .setSignIn()
                      .then((value) =>
                          nextScreenReplace(context, SuccessPage())))));
            }
          });
        }
      });
    }
  }

  void handleAppleLogin() async {
    final SignInBloc sb = Provider.of<SignInBloc>(context);
    final InternetBloc ib = Provider.of<InternetBloc>(context);
    await ib.checkInternet();
    if (ib.hasInternet == false) {
      openSnacbar(_scaffoldKey, 'No internet available');
      openToast1(context, 'No internet available'.tr());
    } else {
      setState(() {
        signInStart = true;
        brandName = 'Apple';
      });

      await sb.signInWithApple().then((_) {
        if (sb.hasError == true) {
          openToast1(
              context,
              'Error with Apple login! Please try with Google or Facebook'
                  .tr());
          setState(() {
            signInStart = false;
          });
        } else {
          sb.checkUserExists().then((value) {
            if (sb.userExists == true) {
              sb.getUserData(sb.uid).then((value) => sb.saveDataToSP().then(
                  (value) => sb.setSignIn().then(
                      (value) => nextScreenReplace(context, SuccessPage()))));
            } else {
              sb.getJoiningDate().then((value) => sb.saveDataToSP().then(
                  (value) => sb.saveToFirebase().then((value) => sb
                      .setSignIn()
                      .then((value) =>
                          nextScreenReplace(context, SuccessPage())))));
            }
          });
        }
      });
    }
  }

  void handleSkip() {
    nextScreenReplace(context, SuccessPage());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 0), () async {
      if (Platform.isIOS) {
        supportsAppleSignIn = await TheAppleSignIn.isAvailable();
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: signInStart == false ? welcomeUI() : loadingUI(brandName!));
  }

  Widget welcomeUI() {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            widget.isSkip != null
                ? Container(
                    height: 100,
                    padding: EdgeInsets.only(top: 15),
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                  )
                : SizedBox(
                    height: 100,
                  ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Welcome to'.tr(),
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
            ),
            Text(
              '${Config().appName}',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 3,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(40)),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(
                'Explore every famous places of beautiful Žiežmariai'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600]),
              ),
            ),
            Spacer(),
            Container(
              height: 45,
              width: w * 0.70,
              child: FlatButton.icon(
                icon: Icon(
                  FontAwesomeIcons.google,
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                label: Text(
                  'Continue with google'.tr(),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 15),
                ),
                color: Colors.deepOrange,
                onPressed: () {
                  handleGoogleLogin();
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 45,
              width: w * 0.70,
              child: FlatButton.icon(
                icon: Icon(
                  FontAwesomeIcons.facebook,
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                label: Text(
                  'Continue with facebook'.tr(),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 15),
                ),
                color: Colors.blueAccent,
                onPressed: () {
                  handleFacebbokLogin();
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            !supportsAppleSignIn
                ? Container()
                : Column(
                    children: [
                      Container(
                        height: 45,
                        width: w * 0.70,
                        child: FlatButton.icon(
                          icon: Icon(
                            FontAwesomeIcons.apple,
                            color: Colors.white,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          label: Text(
                            'Continue with Apple'.tr(),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 15),
                          ),
                          color: Colors.black,
                          onPressed: () {
                            handleAppleLogin();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
            widget.isSkip != null
                ? Container()
                : Container(
                    height: 45,
                    width: w * 0.70,
                    child: FlatButton.icon(
                      icon: Icon(
                        FontAwesomeIcons.bolt,
                        color: Colors.white,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      label: Text(
                        'SKIP'.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 15),
                      ),
                      color: Colors.deepPurpleAccent,
                      onPressed: () {
                        handleSkip();
                      },
                    ),
                  ),
            SizedBox(
              height: h * 0.15,
            )
          ],
        ),
      ),
    );
  }
}
