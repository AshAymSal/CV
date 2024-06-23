import 'package:flutter/material.dart';

Widget colors(List colors) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    height: 50,
    child: Row(children: [
      Expanded(
          child: Text('Colors',
              style: TextStyle(fontSize: 16, fontFamily: "New"))),
      Expanded(
        child: Container(
          height: 20,
          //width: 300,
          child: ListView.builder(
            reverse: true,
            scrollDirection: Axis.horizontal,
            itemCount: colors.length,
            itemBuilder: (BuildContext context, int index) {
              var color = int.parse('0xFF' + colors[index]);
              return Container(
                height: 40,
                width: 30,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Color(color)),
              );
            },
          ),
        ),
      )
    ]),
  );
}
