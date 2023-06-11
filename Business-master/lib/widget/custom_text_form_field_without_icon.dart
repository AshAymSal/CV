import 'package:business/helper/constanc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFormFieldWithoutIcon extends StatelessWidget {
  final String hint;
  final Function validator;
  final TextEditingController? controller;

  CustomTextFormFieldWithoutIcon({
    required this.hint,
    required this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: hint,
          labelStyle: TextStyle(
            color: greyColor,
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: const BorderSide(
              color: greyColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: greyColor),
          ),
        ),
        validator: validator as String? Function(String?)?,
      ),
    );
  }
}
