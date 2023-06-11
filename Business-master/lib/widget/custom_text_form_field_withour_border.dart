import 'package:business/helper/constanc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFormFieldWithoutBorder extends StatelessWidget {
  final String hint;
  final Function onSave;
  final Function validator;
  final Function? onChange;
  final IconData icons;

  CustomTextFormFieldWithoutBorder({
    required this.hint,
    required this.onSave,
    required this.validator,
    this.onChange,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        cursorColor: primaryColor,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icons,
            color: greyColor,
          ),
          labelText: hint,
          labelStyle: TextStyle(
            color: greyColor,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        onChanged: onChange as void Function(String)?,
        validator: validator as String? Function(String?)?,
      ),
    );
  }
}
