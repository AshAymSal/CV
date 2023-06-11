import 'package:ecommernce/model/purchase.dart';
import 'package:ecommernce/model/review.dart';
import 'package:ecommernce/modules/checkout/puchaseProvider.dart';
import 'package:ecommernce/modules/detalis/detalisProvider.dart';
import 'package:ecommernce/modules/detalis/detalisWidgets.dart';
import 'package:ecommernce/modules/reviews/reviewsPage.dart';
import 'package:ecommernce/modules/reviews/reviewsProvider.dart';
import 'package:ecommernce/modules/sales/salesProvider.dart';
import 'package:ecommernce/modules/signIn/signInProvider.dart';
import 'package:ecommernce/modules/signIn/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/components/bottom_sheet/gf_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

import '../category/categoryPage.dart';
import '../../firebase.dart';
import '../../model/product.dart';
import 'package:intl/intl.dart';

class slDetalis extends StatelessWidget {
  product pro;
  String id;
  slDetalis(this.pro, this.id, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<detalisProvider>(
          create: (_) {
            return detalisProvider()..getBestReview(pro.id!);
          },
        )
      ],
      child: sfDetalis(pro, id),
    );
  }
}

class sfDetalis extends StatefulWidget {
  product pro;
  String id;
  sfDetalis(this.pro, this.id, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return stateDetalis(pro, id);
  }
}

class stateDetalis extends State<sfDetalis> {
  TextEditingController textControl = TextEditingController();
  //final GFBottomSheetController sheetController = GFBottomSheetController();
  product? pro;
  String? id;
  review? besReview;
  stateDetalis(this.pro, this.id);

  //IconData a = Icons.favorite_border;
  //Color c = Colors.black;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (id != '-1') {
      detalisProvider
          .getRead(context)
          .isLiked(FirebaseAuth.instance.currentUser!.email!, widget.pro);
    }
    detalisProvider
        .getRead(context)
        .getBestReview(FirebaseAuth.instance.currentUser!.email!);
    textControl.text = "1";
  }

  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height;
    final totalWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(true);
          return true;
        },
        child: Scaffold(
            appBar: AppBar(),
            //bottomSheet: sendRequest(context, pro!,sheetController),
            /* bottomSheet: BottomAppBar(
                child: Container(
              height: 50,
              width: totalWidth,
            )),*/
            body: Container(
              height: totalHeight,
              color: Color(0xffd3faff),
              child: ListView(
                children: [
                  //photos(pro!.images!, width: totalWidth),
                  imagesCarousel(pro!.images!),
                  //Container(height: totalHeight/3,color: Colors.red,),
                  nameAndCost(pro!.name!, pro!.cost!),
                  colors(pro!.colors!),

                  description(pro!.description!),
                  SizedBox(height: 20),
                  rating(double.parse(pro!.rating!)),
                  SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Reviews',
                            style: TextStyle(fontSize: 16, fontFamily: "New"),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            child: Text(
                              'See All Reivews',
                              style: TextStyle(fontSize: 11, fontFamily: "New"),
                              textAlign: TextAlign.end,
                            ),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return slReviewsPage(pro!.id!);
                              }));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  detalisProvider.getWatch(context).bestReview != null
                      ? reviews(context, pro!.id!,
                          detalisProvider.getRead(context).bestReview!)
                      : Container(
                          width: 250,
                          height: 75,
                        ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      sendRequest(context, pro!),
                      //ElevatedButton(onPressed: (){sheetController.showBottomSheet();}, child: Text("sh")),
                      favorite(context, pro!),
                      /* Container(
                          width: 50,
                          child: TextField(
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                            maxLength: 2,
                            maxLines: 1,
                            controller: textControl,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Container(
                          width: 50,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  int now = int.parse(textControl.text);
                                  int after = now + 1;
                                  setState(() {
                                    textControl.text = after.toString();
                                  });
                                },
                                child: Icon(
                                  Icons.arrow_circle_up,
                                  size: 35,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  int now = int.parse(textControl.text);
                                  if (now == 1) {
                                    return;
                                  }
                                  int after = now - 1;
                                  setState(() {
                                    textControl.text = after.toString();
                                  });
                                },
                                child: Icon(
                                  Icons.arrow_circle_down,
                                  size: 35,
                                ),
                              ),
                            ],
                          ),
                        ),*/
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            )));
  }
}
/*ref
                              .where("id", isEqualTo: pro!.id!)
                              .get()
                              .then((value) {
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

 
/*

                                        String daydate =
                                            DateFormat("yyyy-MM-dd")
                                                .format(DateTime.now());
                                        String dattime = DateFormat("HH:mm:ss")
                                            .format(DateTime.now());
                                        CollectionReference ref =
                                            FirebaseFirestore.instance
                                                .collection("users")
                                                .doc(signInProvider
                                                    .getRead(context)
                                                    .us!
                                                    .id!)
                                                .collection("sales");
                                        QuerySnapshot qsshid = await ref
                                            .orderBy("rank", descending: true)
                                            .limit(1)
                                            .get(); // هان برجع كبشة documents
                                        if (qsshid.size > 0) {
                                          final currank =
                                              qsshid.docs[0]["rank"];
                                          int rankint = currank + 1;
                                          ref.add({
                                            "id": pro!.id,
                                            "daytime": dattime,
                                            "daydate": daydate,
                                            "rank": rankint
                                          });
                                        } else {
                                          ref.add({
                                            "id": pro!.id,
                                            "daytime": dattime,
                                            "daydate": daydate,
                                            "rank": 1
                                          });
                                        }
                                        CollectionReference ref2 =
                                            FirebaseFirestore.instance
                                                .collection("products");
                                        QuerySnapshot qsshid2 = await ref2
                                            .where("id", isEqualTo: pro!.id)
                                            .get();
                                        final protimes =
                                            qsshid2.docs[0]["times"];
                                        int curtime = int.parse(protimes);
                                        int plustime = curtime + 1;
                                        ref2.doc(pro!.id).update(
                                            {"times": plustime.toString()});

                                        CollectionReference ref3 =
                                            FirebaseFirestore.instance
                                                .collection("profits");
                                        QuerySnapshot qsshid3 =
                                            await ref3.get();
                                        final prof = qsshid3.docs[0]["total"];
                                        final profid = qsshid3.docs[0]["id"];

                                        int curprof = int.parse(prof);
                                        int plusprof =
                                            curprof + int.parse(pro!.cost!);
                                        ref3.doc(profid).update(
                                            {"total": plusprof.toString()});
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text("Done")));
                                        salesProvider
                                            .getRead(context)
                                            .refreshSales(signInProvider
                                                .getRead(context)
                                                .us!
                                                .id!);
                                        Navigator.pop(context);
                                      */