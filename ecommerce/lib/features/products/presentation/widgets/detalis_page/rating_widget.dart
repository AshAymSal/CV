import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

Widget rating(double Rating) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    //height: 50,
    child: Row(
      children: [
        Expanded(
          child: Text(
            'Rating',
            style: TextStyle(fontSize: 16, fontFamily: "New"),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SmoothStarRating(
                isReadOnly: true,
                rating: Rating,
                size: 20,
                starCount: 5,
              ),
              Text(
                '     ' + Rating.toString(),
                style: TextStyle(fontSize: 16, fontFamily: "New"),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
