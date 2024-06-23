import 'package:ecommernce/features/products/presentation/pages/category_page.dart';
import 'package:flutter/material.dart';

Widget Catigory(BuildContext context, String a, String b) {
  return Container(
      width: MediaQuery.of(context).size.width / 4,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return slCategory(a);
          }));
        },
        child: Card(
          child: Column(
            children: [
              Container(
                  width: 95,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: Image.network(b,
                        width: 95, height: 120, fit: BoxFit.fill),
                  )),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(a,
                    style: TextStyle(
                        color: Colors.white, fontFamily: "New", fontSize: 13)),
              )
            ],
          ),
          color: Colors.blueAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ));
}
