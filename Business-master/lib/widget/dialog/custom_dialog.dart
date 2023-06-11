import 'package:business/widget/button/custom_button.dart';
import 'package:business/widget/custom_text.dart';
import 'package:business/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomInputDialog extends StatelessWidget {
  final double? width;
  final double? height;
  final Function? onPressed;
  final String? buttonText;
  final String? headerText;
  final String? currentContent;
  final bool? showText;
  final String? contentTextWithoutField;
  final TextEditingController? controller;

  CustomInputDialog({
    this.width,
    this.showText,
    this.height,
    this.onPressed,
    this.buttonText,
    this.headerText,
    this.currentContent,
    this.contentTextWithoutField,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    controller!.text = currentContent!;
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Container(
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              text: headerText,
              alignment: Alignment.center,
            ),
            SizedBox(
              height: 16,
            ),
            Divider(
              thickness: 1,
              color: const Color(0x8a000000),
            ),
            SizedBox(
              height: 16,
            ),
            showText!
                ? CustomText(
                    text: contentTextWithoutField,
                    alignment: Alignment.centerRight,
                  )
                : CustomTextFormField(
                    controller: controller,
                    hint: "اضافة تعليق",
                    validator: (String? value) {},
                    maxLines: 3,
                  ),
            SizedBox(
              height: 16,
            ),
            CustomButton(
              text: buttonText,
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
