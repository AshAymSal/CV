import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingStack extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  LoadingStack({required this.child, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        !isLoading ? child : SizedBox(),
        Positioned(
          child: isLoading
              ? Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    child: Lottie.asset('assets/loading.json'),
                    color: Colors.white,
                  ),
                )
              : SizedBox(),
        )
      ],
    );
  }
}
