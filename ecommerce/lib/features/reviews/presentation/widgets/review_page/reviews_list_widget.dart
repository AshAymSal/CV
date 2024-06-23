import 'package:ecommernce/features/reviews/domain/entities/review.dart';
import 'package:ecommernce/features/reviews/presentation/widgets/review_page/one_review_widget.dart';
import 'package:flutter/material.dart';

Widget reviewsListWidget(List<Review> reviews) {
  return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return oneReview(review);
      });
}
