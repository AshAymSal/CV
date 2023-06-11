import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommernce/model/product.dart';
import 'package:ecommernce/model/review.dart';
import 'package:ecommernce/modules/signIn/signInProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommernce/modules/favorites/favoriteProvider.dart';

class detalisProvider extends ChangeNotifier {
  bool liked = false;
  IconData icon = Icons.favorite_border;
  Color iconColor = Colors.black;
  review? bestReview;

  static detalisProvider getWatch(BuildContext context) {
    //print("watch");
    return context.watch<detalisProvider>();
  }

  static detalisProvider getRead(BuildContext context) {
    //print("read");
    return context.read<detalisProvider>();
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

  getBestReview(String id) async {
    //review bestReview;
    print("getting best");
    CollectionReference ref1 =
        FirebaseFirestore.instance.collection("products");
    QuerySnapshot qsshReviews = await ref1
        .doc(id)
        .collection('reviews')
        .orderBy('rating', descending: true)
        .limit(1)
        .get();
    List<QueryDocumentSnapshot> listdocs =
        qsshReviews.docs; // وهان بنحطهم ك list
    listdocs.forEach((element) async {
      print(element);
      bestReview = review(
        text: element['text'],
        id: element['id'],
        name: element['name'],
        rating: element['rating'],
        date: element['date'],
      );
      notifyListeners();
    });
  }
}

class orderProvider extends ChangeNotifier {
  Map<String, String> items = Map();

  static orderProvider getWatch(BuildContext context) {
    //print("watch");
    return context.watch<orderProvider>();
  }

  static orderProvider getRead(BuildContext context) {
    //print("read");
    return context.read<orderProvider>();
  }

  void editItems(String key, String value) {
    if (value == '0') {
      items.remove(key);
      return;
    }
    items[key] = value;
    print(items);
  }
}
