import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

//sort length
void openToast(context, message) {
  //Toast.show(message, context, textColor: Colors.white, backgroundRadius: 20, duration: Toast.LENGTH_SHORT);
  ToastContext().init(context);
  Toast.show(message,
      textStyle: TextStyle(color: Colors.white),
      backgroundRadius: 20,
      duration: Toast.lengthShort);
}

//long length
void openToast1(context, message) {
  //Toast.show(message, context, textColor: Colors.white, backgroundRadius: 20, duration: Toast.LENGTH_LONG);
  ToastContext().init(context);
  Toast.show(message,
      textStyle: TextStyle(color: Colors.white),
      backgroundRadius: 20,
      duration: Toast.lengthLong);
}
