import 'package:ecommernce/features/reviews/domain/entities/review.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

Widget oneReview(Review rev) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    margin: EdgeInsets.symmetric(vertical: 10),
    //height: 50,
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          // height: 70,
          width: 300,
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
                        rev.date!,
                        style: TextStyle(fontSize: 10, fontFamily: "New"),
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
                            rating: double.parse(rev.rating!),
                            size: 12,
                            starCount: 5,
                          ),
                          Text(
                            ' ' + rev.rating!,
                            style: TextStyle(fontSize: 11, fontFamily: "New"),
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
                  "${rev.name} :",
                  style: TextStyle(fontSize: 13, fontFamily: "New"),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, top: 5),
                alignment: Alignment.topLeft,
                child: Text(
                  rev.text!,
                  style: TextStyle(fontSize: 11, fontFamily: "New"),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
