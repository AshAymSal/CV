import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommernce/model/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class homeProvider extends ChangeNotifier {
  List<product> mostPopular = [];

  static homeProvider getWatch(BuildContext context) {
    //print("watch");
    return context.watch<homeProvider>();
  }

  static homeProvider getRead(BuildContext context) {
    //print("read");
    return context.read<homeProvider>();
  }

  Future<List<product>> getPopular() async {
    //mostPopular.clear();
    CollectionReference ref = FirebaseFirestore.instance.collection("products");
    QuerySnapshot qssh = await ref
        .orderBy("times", descending: true)
        .limit(5)
        .get(); // هان برجع كبشة documents
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
          rating: element['rating']);
      mostPopular.add(toAdd);
      /*try {
        notifyListeners();
      } catch (e) {
        print(e);
      }*/
    });
    return mostPopular;
  }
}
