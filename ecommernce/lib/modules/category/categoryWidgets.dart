import 'package:ecommernce/modules/category/categoryProvider.dart';
import 'package:ecommernce/modules/oneProduct/oneProductWidgets.dart';
import 'package:flutter/material.dart';

Widget whichCatigory(String catigory, BuildContext context) {
  if (catigory == "Jackets") {
    return catigoryby("jacket", context);
  } else if (catigory == "T-Shirts") {
    return catigoryby("tshirt", context);
  } else if (catigory == "Jeans") {
    return catigoryby("jeans", context);
  }
  return catigoryby("boots", context);
}

Widget catigoryby(String s, BuildContext context) {
  return FutureBuilder<List>(
    future: categoryProvider.getRead(context).getProductsByCategory(s),
    builder: (context, snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return Center(
            child: CircularProgressIndicator(),
          );
        default:
          return ListView.builder(
              itemCount: categoryProvider.getRead(context).products.length,
              itemBuilder: (context, index) {
                List products = categoryProvider.getRead(context).products;
                final pro = products[index];
                return slOneProduct(pro);
              });
      }
    },
  );
}
