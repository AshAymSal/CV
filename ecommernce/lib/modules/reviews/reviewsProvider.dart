import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommernce/model/product.dart';
import 'package:ecommernce/model/review.dart';
import 'package:ecommernce/modules/signIn/signInProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class reviewsProvider extends ChangeNotifier {
  List<review> reviews = [];

  static reviewsProvider getWatch(BuildContext context) {
    //print("watch");
    return context.watch<reviewsProvider>();
  }

  static reviewsProvider getRead(BuildContext context) {
    //print("read");
    return context.read<reviewsProvider>();
  }

  Future<List<review>> getReviews(String id) async {
    CollectionReference ref1 =
        FirebaseFirestore.instance.collection("products");
    QuerySnapshot qsshReviews = await ref1.doc(id).collection('reviews').get();
    List<QueryDocumentSnapshot> listdocsReviews = qsshReviews.docs;
    listdocsReviews.forEach((element) {
      review toAddReview = review(
        text: element['text'],
        id: element['id'],
        name: element['name'],
        rating: element['rating'],
        date: element['date'],
      );
      reviews.add(toAddReview);
      notifyListeners();
    });
    return reviews;
  }
}
