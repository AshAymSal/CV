import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_text.dart';

class CustomAddPostWidget extends StatelessWidget {
  final Function? onPressed;

  CustomAddPostWidget({
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed as void Function()?,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          padding: EdgeInsets.only(
            right: 20,
          ),
          alignment: Alignment.center,
          height: Get.height * 0.07,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.black38),
          ),
          child: CustomText(
            text: 'انشاء منشور',
            color: Colors.black38,
            alignment: Alignment.centerRight,
          ),
        ),
      ),
    );
  }
}
