import 'package:business/helper/constanc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

void customSnackBar({String message1 = '', required String message2}) {
  Get.snackbar(
    message1,
    message2,
    snackPosition: SnackPosition.BOTTOM,
  );
}

void showToast({required String msg, color = colorBgToastSuccessBg}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

String? getTextButtonGroup(int entered) {
  if (entered == 0) {
    return 'انضمام';
  } else if (entered == 1) {
    return 'تم الانضمام';
  } else if (entered == 2) {
    return 'تم ارسال الطلب';
  }
  return null;
}

String? getTextButtonPages(int entered) {
  if (entered == 0)
    return 'اعجبنى';
  else if (entered == 1) return 'الغاء الاعجاب';

  return null;
}
