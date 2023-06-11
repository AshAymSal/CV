import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:new_travel/blocs/place_bloc.dart';
import 'package:new_travel/blocs/recommanded_places_bloc.dart';
import 'package:new_travel/pages/place_details.dart';
import 'package:new_travel/utils/cached_image.dart';
import 'package:new_travel/utils/next_screen.dart';

import 'package:easy_localization/easy_localization.dart';

class OtherPlaces extends StatelessWidget {
  OtherPlaces({Key? key, this.audioFileName}) : super(key: key);

  final String? audioFileName;

  @override
  Widget build(BuildContext context) {
    final RecommandedPlacesBloc rpb =
        Provider.of<RecommandedPlacesBloc>(context);
    double w = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('You May Also Like'.tr(),
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                fontFamily: 'Poppins')),
        Container(
          margin: EdgeInsets.only(top: 8, bottom: 20),
          height: 3,
          width: 130,
          decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(40)),
        ),
        Container(
          height: 205,
          width: w,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: rpb.data.take(6).length,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: 10);
            },
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                child: Stack(
                  children: <Widget>[
                    Hero(
                      tag: 'other$index',
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(10)),
                        height: 200,
                        width: w * 0.35,
                        child: cachedImage(rpb.data[index]['image-1'], 10),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 15,
                      height: 35,
                      width: 80,
                      child: FlatButton.icon(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        color: Colors.grey, //Colors.grey[600].withOpacity(0.5),
                        icon: Icon(
                          LineIcons.heart,
                          color: Colors.white,
                          size: 20,
                        ),
                        label: Text(
                          rpb.data[index]['loves'].toString(),
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      left: 10,
                      right: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(rpb.data[index]['place name'],
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    )
                  ],
                ),
                onTap: () {
                  replaceScreen(
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
                        tag: 'others$index',
                      ));
                },
              );
            },
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
