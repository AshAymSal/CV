import 'dart:async';

import 'package:business/core/widget/image_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TypingComponent extends StatefulWidget {
  final String receiverImage;
  TypingComponent({required this.receiverImage});

  @override
  _TypingComponentState createState() => _TypingComponentState();
}

class _TypingComponentState extends State<TypingComponent> {
  double mediumSize = 10.h;
  double bigSize = 12.h;
  double smallSize = 6.h;

  double dot1 = 6.h, dot2 = 10.h, dot3 = 12.h;
  Timer? timerRunning;

  void timer() {
    timerRunning = Timer(
      Duration(milliseconds: 600),
      () {
        setState(() {
          if (dot1 == smallSize) {
            dot1 = bigSize;
            dot3 = smallSize;
          } else {
            dot1 = smallSize;
            dot3 = bigSize;
          }
          timer();
        });
      },
    );
  }

  @override
  void dispose() {
    timerRunning!.cancel();
    super.dispose();
  }

  @override
  void initState() {
    timer();
    super.initState();
  }

  Widget dotWedget({
    required double size,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0.h),
        color: const Color(0xfffd6c57),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 0, left: 9.w),
          child: ImageProfile(
            size: 65.h,
            imageWidget: Image.network(
              widget.receiverImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 60.h,
          width: 78.w,
          margin: EdgeInsets.symmetric(vertical: 21.h),
          decoration: BoxDecoration(
              color: const Color(0xfff9f9f9),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0.h),
                  bottomRight: Radius.circular(30.0.h),
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(30.0.h))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              dotWedget(size: dot1),
              SizedBox(
                width: 7.w,
              ),
              dotWedget(size: dot2),
              SizedBox(
                width: 7.w,
              ),
              dotWedget(size: dot3),
            ],
          ),
        ),
      ],
    );
  }
}
