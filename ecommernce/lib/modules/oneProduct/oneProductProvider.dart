import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommernce/model/product.dart';
import 'package:ecommernce/modules/favorites/favoriteProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class oneProductProvider extends ChangeNotifier {
  bool liked = false;
  IconData icon = Icons.favorite_border;
  Color iconColor = Colors.black;

  static oneProductProvider getWatch(BuildContext context) {
    //print("watch");
    return context.watch<oneProductProvider>();
  }

  static oneProductProvider getRead(BuildContext context) {
    //print("read");
    return context.read<oneProductProvider>();
  }

  void isLiked(String id, product pro) {
    CollectionReference ref = FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("favorites");
    ref.where("id", isEqualTo: pro.id!).get().then((value) {
      if (value.size > 0) {
        icon = Icons.favorite;
        iconColor = Colors.red;
        liked = true;
        notifyListeners();
      } else {
        icon = Icons.favorite_border;
        iconColor = Colors.black;
        liked = false;
        notifyListeners();
      }
    });
  }

  void buttonPressed(BuildContext context, String id, product pro) {
    CollectionReference ref = FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("favorites");
    if (liked) {
      ref.where("id", isEqualTo: pro.id!).get().then((value) {
        QueryDocumentSnapshot qd = value.docs[0];
        ref.doc(qd.id).delete().then((value) {
          icon = Icons.favorite_border;
          iconColor = Colors.black;
          liked = false;
          favoriteProvider.getRead(context).removeFromFavoritesAsId(pro);
          notifyListeners();
        });
      });
    } else {
      ref.where("id", isEqualTo: pro.id!).get().then((value) {
        ref.add({
          "id": pro.id!,
        }).then((value) {
          ref.doc(value.id).update({"fav id": value.id}).then((value) {
            icon = Icons.favorite;
            iconColor = Colors.red;
            liked = true;
            favoriteProvider.getRead(context).addToFavorites(pro);
            notifyListeners();
          });
        });
      });
    }
  }
  /*ref.where("id", isEqualTo: pro!.id!).get().then((value) {
      if (value.size > 0) {
        QueryDocumentSnapshot qd = value.docs[0];
        ref.doc(qd.id).delete();
        setState(() {
          a = Icons.favorite_border;
          c = Colors.black;
        });
      } else {
        ref.add({
          "id": pro!.id!,
        }).then((value) {
          ref.doc(value.id).update({"fav id": value.id});
        });
        setState(() {
          a = Icons.favorite;
          c = Colors.red;
        });
      }
    });*/
}
