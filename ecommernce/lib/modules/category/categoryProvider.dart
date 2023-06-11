import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommernce/model/product.dart';
import 'package:ecommernce/model/review.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class categoryProvider extends ChangeNotifier {
  List<product> products = [];

  static categoryProvider getWatch(BuildContext context) {
    //print("watch");
    return context.watch<categoryProvider>();
  }

  static categoryProvider getRead(BuildContext context) {
    //print("read");
    return context.read<categoryProvider>();
  }

  Future<List<product>> getProductsByCategory(String cat) async {
    CollectionReference ref1 =
        FirebaseFirestore.instance.collection("products");
    QuerySnapshot qssh = await ref1.where("type", isEqualTo: cat).get();
    List<QueryDocumentSnapshot> listdocs = qssh.docs; // وهان بنحطهم ك list
    listdocs.forEach((element) async {
      product toAdd = product(
        name: element["name"],
        id: element["id"],
        type: element["type"],
        times: element["times"],
        cost: element["cost"],
        images: element["images"],
        description: element["description"],
        sizes: element['sizes'],
        colors: element['colors'],
        rating: element['rating'],
      );
      products.add(toAdd);
    });
    return products;
  }
}
