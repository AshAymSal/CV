import 'package:ecommernce/features/reviews/domain/entities/review.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

Widget reviews(BuildContext context, String id, Review bestReview) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    //height: 50,
    child: Column(
      children: [
        SizedBox(height: 7),
        Container(
          height: 70,
          width: 250,
          color: Colors.white54,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 15, top: 10),
                      alignment: Alignment.topLeft,
                      child: Text(
                        bestReview.date!,
                        style: TextStyle(fontSize: 8, fontFamily: "New"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(right: 15, top: 10),
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SmoothStarRating(
                            rating: 4.2,
                            size: 10,
                            starCount: 5,
                          ),
                          Text(
                            ' ${bestReview.rating}',
                            style: TextStyle(fontSize: 9, fontFamily: "New"),
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 15, top: 5),
                alignment: Alignment.topLeft,
                child: Text(
                  "${bestReview.name} :",
                  style: TextStyle(fontSize: 11, fontFamily: "New"),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, top: 5),
                alignment: Alignment.topLeft,
                child: Text(
                  bestReview.text!,
                  style: TextStyle(fontSize: 9, fontFamily: "New"),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
