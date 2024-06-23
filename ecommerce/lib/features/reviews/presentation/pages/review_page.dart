import 'package:ecommernce/features/reviews/domain/entities/review.dart';
import 'package:ecommernce/features/reviews/presentation/widgets/review_page/reviews_list_widget.dart';
import 'package:flutter/material.dart';

class slReviewsPage extends StatelessWidget {
  List<Review> reviews;
  //String id;
  slReviewsPage({Key? key, required this.reviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return sfReviewsPage(reviews: reviews);
  }
}

class sfReviewsPage extends StatefulWidget {
  //String id;
  List<Review> reviews;
  sfReviewsPage({Key? key, required this.reviews}) : super(key: key);

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
                child: reviewsListWidget(widget.reviews))
          ],
        ),
      ),
    );
  }
}
