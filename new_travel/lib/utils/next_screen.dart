

import 'package:flutter/material.dart';

Future<void> nextScreen (context, page)async{
  await Navigator.push(context, MaterialPageRoute(
    builder: (context) => page));
}

void replaceScreen(context, page){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenCloseOthers (context, page){
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => page), (route) => false);
}

void nextScreenReplace (context, page){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
}