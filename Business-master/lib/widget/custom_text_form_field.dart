import 'package:business/helper/constanc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final isPasswordProvider = StateProvider<bool>((red) => false);

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final Function? validator;
  final IconData? icons;
  final TextEditingController? controller;
  final bool isPassword;
  final int? maxLines;
  final double? height;
  EdgeInsets? contentPadding;
  TextInputType? keyboardType;
  ValueChanged<String>? onChanged;
  Color? fillColor;
  double? borderRaduisSize;
  CustomTextFormField({
    required this.hint,
    this.validator,
    this.icons,
    required this.controller,
    this.isPassword = false,
    this.maxLines = 1,
    this.height,
    this.contentPadding,
    this.keyboardType,
    this.onChanged,
    this.fillColor,
    this.borderRaduisSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Consumer(
          builder: (BuildContext context,
              T Function<T>(ProviderBase<Object, T>) watch, Widget? child) {
            return TextFormField(
              maxLines: maxLines,
              controller: controller,
              keyboardType: keyboardType,
              onChanged: onChanged,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  icons,
                  color: greyColor,
                ),
                labelText: hint,
                fillColor: fillColor ?? const Color(0xfff0f0f0),
                labelStyle: TextStyle(
                  color: greyColor,
                ),
                contentPadding: contentPadding ??
                    EdgeInsets.symmetric(
                      vertical: 13.0.h,
                      horizontal: 16.w,
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
                suffixIcon: isPassword
                    ? IconButton(
                        icon: watch(isPasswordProvider).state
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                        color: primaryColor,
                        onPressed: () {
                          watch(isPasswordProvider).state =
                              !watch(isPasswordProvider).state;
                        },
                      )
                    : null,
              ),
              obscureText:
                  isPassword ? !watch(isPasswordProvider).state : false,
              validator: validator as String? Function(String?)?,
            );
          },
        ),
      ),
    );
  }
}
