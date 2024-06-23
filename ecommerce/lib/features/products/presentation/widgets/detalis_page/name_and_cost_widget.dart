import 'package:flutter/material.dart';

Widget nameAndCost(String name, String cost) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    height: 50,
    child: Row(
      children: [
        Expanded(
          child: Text(
            name,
            style: TextStyle(fontSize: 16, fontFamily: "New"),
          ),
        ),
        Expanded(
          child: Text(
            "\$" + cost,
            style: TextStyle(fontSize: 16, fontFamily: "New"),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    ),
  );
}
