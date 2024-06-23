import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/products/presentation/widgets/detalis_page/request_dialog_widget.dart';
import 'package:flutter/material.dart';

Widget sendRequest(BuildContext context, Product pro) {
  return Container(
    height: 50,
    width: 200,
    margin: EdgeInsets.symmetric(horizontal: 20),
    child: ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            var selectedIndex = 0;
            return slAlert(selectedIndex, pro);
          },
        );
      },
      child: Text(
        "Start Request",
        style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: "New"),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ))),
    ),
  );
}
