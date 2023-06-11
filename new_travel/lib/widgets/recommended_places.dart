import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:new_travel/blocs/recommanded_places_bloc.dart';
import 'package:new_travel/pages/place_details.dart';
import 'package:new_travel/utils/cached_image.dart';
import 'package:new_travel/utils/loading_animation.dart';
import 'package:new_travel/utils/next_screen.dart';

import 'package:easy_localization/easy_localization.dart';

class RecommendedPlaces extends StatelessWidget {
  RecommendedPlaces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RecommandedPlacesBloc rpb =
        Provider.of<RecommandedPlacesBloc>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 15, top: 20, bottom: 0),
          child: Text(
            'Recommended Places'.tr(),
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                color: Colors.grey[800]),
          ),
        ),
        rpb.data.isEmpty
            ? Container(height: 300, child: LoadingWidget1())
            : ListView.builder(
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: rpb.data.take(10).length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    child: Stack(
                      children: <Widget>[
                        Hero(
                          tag: 'recommended$index',
                          child: Container(
                              margin: EdgeInsets.only(
                                  top: 15, left: 15, right: 15, bottom: 0),
                              height: 230,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.grey, //Colors.grey[300],
                                        blurRadius: 10,
                                        offset: Offset(3, 3))
                                  ]),
                              child:
                                  cachedImage(rpb.data[index]['image-1'], 10)),
                        ),
                        Positioned(
                          right: 30,
                          top: 30,
                          height: 35,
                          width: 80,
                          child: FlatButton.icon(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                            color: Colors
                                .grey, // Colors.grey[600].withOpacity(0.5),
                            icon: Icon(
                              LineIcons.heart,
                              color: Colors.white,
                              size: 20,
                            ),
                            label: Text(
                              rpb.data[index]['loves'].toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            width: MediaQuery.of(context).size.width,
                            height: 80,
                            child: Container(
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.only(left: 15, right: 15),
                              decoration: BoxDecoration(
                                  color: Colors
                                      .grey, // Colors.grey[900].withOpacity(0.6),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    rpb.data[index]['place name'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.location_on,
                                          size: 16, color: Colors.grey[400]),
                                      Expanded(
                                        child: Text(
                                          rpb.data[index]['location'],
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[400],
                                              fontWeight: FontWeight.w600),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                    onTap: () {
                      nextScreen(
                          context,
                          PlaceDetailsPage(
                            placeName: rpb.data[index]['place name'],
                            location: rpb.data[index]['location'],
                            description: rpb.data[index]['description'],
                            timestamp: rpb.data[index]['timestamp'],
                            lat: rpb.data[index]['latitude'],
                            lng: rpb.data[index]['longitude'],
                            filename: rpb.data[index]['file_name'],
                            images: [rpb.data[index]['image-1']] +
                                rpb.data[index]['images'],
                            tag: 'recommended$index',
                          ));
                    },
                  );
                },
              ),
        SizedBox(
          height: 50,
        )
      ],
    );
  }
}
