import 'package:business/helper/constanc.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomBorderButton extends StatelessWidget {
  final String? text;
  final Color color;
  final Function? onPressed;
  final double? height;

  CustomBorderButton({
    required this.onPressed,
    required this.text,
    this.color = primaryColor,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
            side: BorderSide(
              color: primaryColor,
            ),
          ),
        ),
        onPressed: onPressed as void Function()?,
        child: CustomText(
          alignment: Alignment.center,
          text: text,
          color: darkColor,
        ),
      ),
    );
  }
}
