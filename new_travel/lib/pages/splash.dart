import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:new_travel/blocs/sign_in_bloc.dart';
import 'package:new_travel/models/config.dart';
import 'package:new_travel/pages/wellcome.dart';
import 'package:new_travel/widgets/navbar.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController? _controller;

  nextPage() {
    final SignInBloc sb = Provider.of<SignInBloc>(context, listen: false);
    sb.checkSignIn();
    var page = sb.isSignedIn == false ? WellComePage() : NavBar();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _controller!.forward();
    Future.delayed(Duration(milliseconds: 3000)).then((value) => nextPage());
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: RotationTransition(
          turns: Tween(begin: 0.0, end: 1.0).animate(_controller!),
          child: Image(
            image: AssetImage(Config().splashIcon),
            height: 120,
            width: 120,
            fit: BoxFit.contain,
          )),
    ));
  }
}
