import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:new_travel/blocs/place_bloc.dart';

import 'package:new_travel/models/variables.dart';
import 'package:new_travel/pages/place_details.dart';
import 'package:new_travel/utils/cached_image.dart';
import 'package:new_travel/utils/loading_animation.dart';
import 'package:new_travel/utils/next_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

class Featured extends StatefulWidget {
  Featured({Key? key}) : super(key: key);

  _FeaturedState createState() => _FeaturedState();
}

class _FeaturedState extends State<Featured> {
  int listIndex = 2;

  @override
  Widget build(BuildContext context) {
    final PlaceBloc pb = Provider.of<PlaceBloc>(context, listen: false);
    double w = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 15, top: 10, bottom: 15),
          child: Text(
            'Featured Places'.tr(),
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                color: Colors.grey[800]),
          ),
        ),
        Container(
          height: 280,
          width: w,
          child: pb.data.isEmpty
              ? LoadingWidget2()
              : PageView.builder(
                  controller: PageController(initialPage: 2),
                  scrollDirection: Axis.horizontal,
                  itemCount: pb.data.take(5).length,
                  onPageChanged: (index) {
                    setState(() {
                      listIndex = index;
                    });
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: SizedBox(
                        width: w,
                        child: InkWell(
                          child: Stack(
                            children: <Widget>[
                              Hero(
                                tag: 'featured$index',
                                child: Container(
                                  height: 230,
                                  width: w,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      borderRadius: BorderRadius.circular(10)),
                                  child: cachedImage(
                                      pb.data[index]['image-1'], 10),
                                ),
                              ),
                              Positioned(
                                height: 120,
                                width: w * 0.70,
                                left: w * 0.11,
                                bottom: 15,
                                child: Container(
                                  //margin: EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color:
                                                Colors.grey, //Colors.grey[200],
                                            offset: Offset(0, 2),
                                            blurRadius: 2)
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            pb.data[index]['place name'],
                                            style: textStyleFeaturedtitle,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(
                                              Icons.location_on,
                                              size: 16,
                                              color: Colors.grey,
                                            ),
                                            Expanded(
                                              child: Text(
                                                pb.data[index]['location'],
                                                style: subtitleTextStyle,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          ],
                                        ),
                                        Divider(
                                          color: Colors.grey[300],
                                          height: 20,
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Icon(
                                                LineIcons.heart,
                                                size: 18,
                                                color: Colors.orange,
                                              ),
                                              Text(
                                                pb.data[index]['loves']
                                                    .toString(),
                                                style: textStylicon,
                                              ),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              Icon(
                                                //LineIcons.comment_o,
                                                LineIcons.comment,
                                                size: 18,
                                                color: Colors.orange,
                                              ),
                                              Text(
                                                pb.data[index]['comments count']
                                                    .toString(),
                                                style: textStylicon,
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            nextScreen(
                                context,
                                PlaceDetailsPage(
                                  placeName: pb.data[index]['place name'],
                                  location: pb.data[index]['location'],
                                  description: pb.data[index]['description'],
                                  timestamp: pb.data[index]['timestamp'],
                                  lat: pb.data[index]['latitude'],
                                  lng: pb.data[index]['longitude'],
                                  filename: pb.data[index]['file_name'],
                                  images: [pb.data[index]['image-1']] +
                                      pb.data[index]['images'],
                                  tag: 'featured$index',
                                ));
                          },
                        ),
                      ),
                    );
                  },
                ),
        ),
        Center(
          child: DotsIndicator(
            dotsCount: 5,
            position: listIndex.toDouble(),
            decorator: DotsDecorator(
              color: Colors.black26,
              activeColor: Colors.black,
              spacing: EdgeInsets.only(left: 6),
              size: const Size.square(7.0),
              activeSize: const Size(25.0, 5.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
          ),
        )
      ],
    );
  }
}
