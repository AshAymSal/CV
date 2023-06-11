import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommernce/model/product.dart';
import 'package:ecommernce/model/purchase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class salesProvider extends ChangeNotifier {
  List<purchase> sales = [];

  static salesProvider getWatch(BuildContext context) {
    //print("watch");
    return context.watch<salesProvider>();
  }

  static salesProvider getRead(BuildContext context) {
    //print("read");
    return context.read<salesProvider>();
  }

  Future<List<purchase>> getSales(String id) async {
    //sales.clear();
    CollectionReference ref = FirebaseFirestore.instance.collection("products");
    QuerySnapshot ref2 = await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("sales")
        .get();
    ref2.docs.forEach((elementt) {
      // List<QueryDocumentSnapshot> listid = qsshid.docs; // وهان بنحطهم ك list
      //  List<product> ids = [];
      String id = elementt["id"];
      String time = elementt["daytime"];
      String date = elementt["daydate"];
      List images = elementt["images"];
      String name = elementt["name"];
      String cost = elementt["cost"];

      String quantity = elementt["quantity"];
      product p = product(
        cost: cost,
        id: id,
        daydate: date,
        daytime: time,
        images: images,
        name: name,
      );
      purchase pur = purchase(p: p, quantity: quantity);
      sales.add(pur);
      notifyListeners();
      //print("${date} l ${time}");
      //  ids.add(p);
    });

    return sales;
  }

  void refreshSales(String id) {
    sales.clear();
    getSales(id);
  }
}
