import 'package:flutter/material.dart';

Widget description(String description) {
  return Container(
    //height: 100,
    //width: 300,
    margin: const EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: Colors.blue,
        width: 0.5,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Container(
      alignment: Alignment.topLeft,
      child: Text(
        description,
        textAlign: TextAlign.left,
        style: TextStyle(fontFamily: "New", fontSize: 13),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    ),
  );
}
