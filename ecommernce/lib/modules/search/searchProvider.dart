import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommernce/model/product.dart';
import 'package:ecommernce/model/purchase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class searchProvider extends ChangeNotifier {
  static searchProvider getWatch(BuildContext context) {
    //print("watch");
    return context.watch<searchProvider>();
  }

  static searchProvider getRead(BuildContext context) {
    //print("read");
    return context.read<searchProvider>();
  }

  Future<List<product>> getProductsBySearch(String query) async {
    List<product> products = [];
    //products.clear();
    CollectionReference ref1 =
        FirebaseFirestore.instance.collection("products");
    if (!query.isEmpty) {
      QuerySnapshot qssh = await ref1
          .where("name",
              isGreaterThanOrEqualTo: query,
              isLessThan: query.substring(0, query.length - 1) +
                  String.fromCharCode(query.codeUnitAt(query.length - 1) + 1))
          .get();
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
        //notifyListeners();
      });
    }

    return products;
  }
}
