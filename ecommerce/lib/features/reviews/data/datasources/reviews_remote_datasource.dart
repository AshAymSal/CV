import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommernce/features/reviews/data/models/review_model.dart';

abstract class ReviewsRemoteDataSource {
  Future<List<ReviewModel>> getAllReviews({required String productId});
  Future<ReviewModel> getBestReview({required String productId});
}

class ReviewsRemoteDataSourceImpl implements ReviewsRemoteDataSource {
  ReviewsRemoteDataSourceImpl();

  @override
  Future<List<ReviewModel>> getAllReviews({required String productId}) async {
    List<ReviewModel> reviews = [];
    CollectionReference ref1 =
        FirebaseFirestore.instance.collection("products");
    QuerySnapshot qsshReviews =
        await ref1.doc(productId).collection('reviews').get();
    List<QueryDocumentSnapshot> listdocsReviews = qsshReviews.docs;
    listdocsReviews.forEach((element) {
      ReviewModel toAddReview = ReviewModel(
        text: element['text'],
        id: element['id'],
        name: element['name'],
        rating: element['rating'],
        date: element['date'],
      );
      reviews.add(toAddReview);
    });
    return reviews;
  }

  @override
  Future<ReviewModel> getBestReview({required productId}) async {
    ReviewModel bestReview = ReviewModel();
    //print("getting best");
    CollectionReference ref1 =
        FirebaseFirestore.instance.collection("products");
    QuerySnapshot qsshReviews = await ref1
        .doc(productId)
        .collection('reviews')
        .orderBy('rating', descending: true)
        .limit(1)
        .get();
    List<QueryDocumentSnapshot> listdocs =
        qsshReviews.docs; // وهان بنحطهم ك list
    listdocs.forEach((element) {
      print(element);
      bestReview = ReviewModel(
        text: element['text'],
        id: element['id'],
        name: element['name'],
        rating: element['rating'],
        date: element['date'],
      );
    });
    return bestReview;
  }
}
