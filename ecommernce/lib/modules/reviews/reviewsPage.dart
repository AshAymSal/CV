import 'package:ecommernce/model/review.dart';
import 'package:ecommernce/modules/detalis/detalisWidgets.dart';
import 'package:flutter/material.dart';
import 'package:ecommernce/modules/reviews/reviewsProvider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class slReviewsPage extends StatelessWidget {
  String id;
  slReviewsPage(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<reviewsProvider>(
          create: (_) {
            return reviewsProvider()..getReviews(id);
          },
        )
      ],
      child: sfReviewsPage(id),
    );
  }
}

class sfReviewsPage extends StatefulWidget {
  String id;
  sfReviewsPage(this.id, {Key? key}) : super(key: key);

  @override
  State<sfReviewsPage> createState() => stateReviewsPage();
}

class stateReviewsPage extends State<sfReviewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Reviews"),
      ),
      body: Container(
        //height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xffd3faff),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
                height: MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height -
                    40 -
                    34,
                color: Color(0xffd3faff),
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: reviewsProvider.getWatch(context).reviews.length,
                    itemBuilder: (context, index) {
                      final review =
                          reviewsProvider.getWatch(context).reviews[index];
                      return oneReview(review);
                    }))
          ],
        ),
      ),
    );
  }

  Widget oneReview(review rev) {
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
}
