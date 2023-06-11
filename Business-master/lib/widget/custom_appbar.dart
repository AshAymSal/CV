import 'package:business/helper/constanc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_text.dart';

Widget? customAppBar({required String title, bool? withLeading}) {
  return AppBar(
    elevation: 0.0,
    titleSpacing: 0.0,
    centerTitle: true,
    backgroundColor: Colors.white,
    title: CustomText(
      text: title,
      alignment: Alignment.center,
      fontSize: 18,//Mina Changed from 24  5/1/2022
    ),
    automaticallyImplyLeading: false,
  );
}

Widget customAppBarWithLeading({required String title, bool? withAction}) {
  return AppBar(
      elevation: 0.0,
      titleSpacing: 0.0,
      centerTitle: true,
      backgroundColor: Colors.white,
      title: Padding(
        padding: const EdgeInsets.only(right: 40,top: 25),
        child: CustomText(
          text: title,
          alignment: Alignment.center,
          fontSize: 24,
          color: primaryColor,
        ),
      ),
      leading: IconButton(
        color: Colors.black,
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.arrow_back_ios_sharp),
      )
  );
}

Widget customAppBarWithPagesAndGroup({
  required String title,
  required Function onPress,
}) {
  return AppBar(
    elevation: 0.0,
    titleSpacing: 0.0,
    centerTitle: true,
    backgroundColor: Colors.white,
    title: CustomText(
      text: title,
      alignment: Alignment.center,
      fontSize: 24,
    ),
    leading: IconButton(
      color: Colors.black,
      onPressed: () {
        Get.back();
      },
      icon: Icon(Icons.arrow_back_ios_sharp),
    ),
    actions: [
      GestureDetector(
        onTap: onPress as void Function()?,
        child: Row(
          children: [
            CustomText(
              alignment: Alignment.center,
              color: primaryColor,
              text: 'انشاء',
            ),
            Icon(
              Icons.add,
              color: primaryColor,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      )
    ],
  );
}
