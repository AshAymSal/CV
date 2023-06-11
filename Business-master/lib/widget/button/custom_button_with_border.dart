import 'package:business/helper/constanc.dart';
import 'package:flutter/material.dart';

import '../custom_text.dart';

class CustomButtonWithBorder extends StatelessWidget {
  final String? text;
  final Color borderColor;
  final Color textColor;
  final Function onPress;
  final double? height;
  final double? width;

  CustomButtonWithBorder({
    required this.onPress,
    required this.text,
    required this.textColor,
    this.borderColor = primaryColor,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: TextButton(
        onPressed: onPress as void Function()?,
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: CustomText(
          alignment: Alignment.center,
          text: text,
        ),
      ),
    );
  }
}
