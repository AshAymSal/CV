import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommernce/model/product.dart';
import 'package:ecommernce/modules/signIn/signInProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class favoriteProvider extends ChangeNotifier {
  List<product> favorites = [];

  static favoriteProvider getWatch(BuildContext context) {
    //print("watch");
    return context.watch<favoriteProvider>();
  }

  static favoriteProvider getRead(BuildContext context) {
    //print("read");
    return context.read<favoriteProvider>();
  }

  Future<List<product>> getFavorites(String id) async {
    favorites.clear();
    CollectionReference ref = FirebaseFirestore.instance.collection("products");
    CollectionReference ref2 = FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("favorites");
    QuerySnapshot qsshid = await ref2.get(); // هان برجع كبشة documents
    List<QueryDocumentSnapshot> listid = qsshid.docs; // وهان بنحطهم ك list
    List<String> ids = [];
    listid.forEach((elementt) {
      String id = elementt["id"];
      ids.add(id);
    });
    ids.forEach((elemente) async {
      QuerySnapshot qsshpro = await ref.where("id", isEqualTo: elemente).get();
      if (qsshpro.docs.isEmpty) {
        QuerySnapshot qsshproo =
            await ref2.where("id", isEqualTo: elemente).get();
        String id = qsshproo.docs[0]["fav id"];
        ref2.doc(id).delete();
      } else {
        final element = qsshpro.docs[0];
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
        favorites.add(toAdd);
        try {
          notifyListeners();
        } catch (e) {}
      }
    });
    return favorites;
  }

  void refreshFavorites() {
    favorites.clear();
    getFavorites(FirebaseAuth.instance.currentUser!.email!);
  }

  void removeFromFavorites(String id, int i, product pro) {
    CollectionReference ref = FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("favorites");
    ref.where("id", isEqualTo: pro.id!).get().then((value) {
      QueryDocumentSnapshot qd = value.docs[0];
      ref.doc(qd.id).delete();
    }).then((value) {
      favorites.removeAt(i);
      notifyListeners();
    });
  }

  void removeFromFavoritesAsId(product pro) {
    favorites.removeWhere((element) => element.id == pro.id);
    notifyListeners();
  }

  void addToFavorites(product pro) {
    favorites.add(pro);
    notifyListeners();
  }
}
