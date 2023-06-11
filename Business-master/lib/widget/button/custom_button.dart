import 'package:business/helper/constanc.dart';
import 'package:flutter/material.dart';

import '../custom_text.dart';
//Mina 10/1/2022 Design Changes

class CustomButton extends StatelessWidget {
  final String? text;
  final Color? color;
  final Color textColor;
  final Function? onPressed;
  final double? height;
  final double? width;
  final double? padding;
  final double fontSize;
  final BorderRadiusGeometry? borderRadiusGeometry;
  final BorderSide ? borderSide;

  CustomButton({
    required this.onPressed,
    required this.text,
    this.textColor = Colors.white,
    this.color = primaryColor,
    this.height,
    this.width,
    this.padding = 0,
    this.fontSize = 16,
    this.borderRadiusGeometry,
    this.borderSide,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: padding!),
      height: height,
      width: width,
      child: TextButton(
        onPressed: onPressed as void Function()?,
        style: TextButton.styleFrom(
          primary: color,
          backgroundColor: color,
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadiusGeometry ?? BorderRadius.circular(10.0),
             side: borderSide ?? BorderSide(color: Colors.white, width: 0)
          ),
        ),
        child: CustomText(
          alignment: Alignment.center,
          text: text,
          color: textColor,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
