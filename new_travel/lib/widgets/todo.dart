import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:new_travel/blocs/user_bloc.dart';
import 'package:new_travel/pages/comments.dart';
import 'package:new_travel/pages/guide.dart';
import 'package:new_travel/pages/hotel.dart';
import 'package:new_travel/pages/restaurant.dart';
import 'package:new_travel/pages/wellcome.dart';
import 'package:new_travel/utils/next_screen.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:new_travel/utils/toast.dart';

Widget todo(context, placeName, timestamp, lat, lng) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text('To Do'.tr(),
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              fontFamily: 'Poppins')),
      Container(
        margin: EdgeInsets.only(top: 8, bottom: 8),
        height: 3,
        width: 50,
        decoration: BoxDecoration(
            color: Colors.blueAccent, borderRadius: BorderRadius.circular(40)),
      ),
      Container(
        //color: Colors.brown,
        height: 180,
        //width: w,
        child: GridView.count(
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          childAspectRatio: 1.4,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            InkWell(
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey, //Colors.grey[200],
                              offset: Offset(5, 5),
                              blurRadius: 2)
                        ]),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey, //Colors.blueAccent[400],
                                offset: Offset(5, 5),
                                blurRadius: 2)
                          ]),
                      child: Icon(
                        //LineIcons.hand_o_left,
                        LineIcons.handPointingLeft,
                        size: 30,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    left: 15,
                    child: Text(
                      'Travel Guide'.tr(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                  )
                ],
              ),
              onTap: () {
                nextScreen(
                    context,
                    GuidePage(
                      lat: lat,
                      lng: lng,
                      placeName: placeName,
                    ));
              },
            ),
//                InkWell(
//                  child: Stack(
//                    children: <Widget>[
//                      Container(
//                        decoration: BoxDecoration(
//                            color: Colors.orangeAccent,
//                            borderRadius: BorderRadius.circular(10),
//                            boxShadow: <BoxShadow>[
//                              BoxShadow(
//                                  color: Colors.grey[200],
//                                  offset: Offset(5, 5),
//                                  blurRadius: 2)
//                            ]),
//                      ),
//                      Positioned(
//                        top: 10,
//                        left: 10,
//                        child: Container(
//                          height: 60,
//                          width: 60,
//                          decoration: BoxDecoration(
//                              shape: BoxShape.circle,
//                              color: Colors.white,
//                              boxShadow: <BoxShadow>[
//                                BoxShadow(
//                                    color: Colors.orangeAccent[400],
//                                    offset: Offset(5, 5),
//                                    blurRadius: 2)
//                              ]),
//                          child: Icon(
//                            LineIcons.hotel,
//                            size: 30,
//                          ),
//                        ),
//                      ),
//                      Positioned(
//                        bottom: 15,
//                        left: 15,
//                        child: Text(
//                          'Nearby Hotels',
//                          style: TextStyle(
//                              color: Colors.white,
//                              fontWeight: FontWeight.w600,
//                              fontSize: 14),
//                        ),
//                      )
//                    ],
//                  ),
//                  onTap: () {
//                   nextScreen(context, HotelPage(lat: lat, lng: lng));
//
//                  },
//                ),
//                InkWell(
//                  child: Stack(
//                    children: <Widget>[
//                      Container(
//                        decoration: BoxDecoration(
//                            color: Colors.pinkAccent,
//                            borderRadius: BorderRadius.circular(10),
//                            boxShadow: <BoxShadow>[
//                              BoxShadow(
//                                  color: Colors.grey[200],
//                                  offset: Offset(5, 5),
//                                  blurRadius: 2)
//                            ]),
//                      ),
//                      Positioned(
//                        top: 10,
//                        left: 10,
//                        child: Container(
//                          height: 60,
//                          width: 60,
//                          decoration: BoxDecoration(
//                              shape: BoxShape.circle,
//                              color: Colors.white,
//                              boxShadow: <BoxShadow>[
//                                BoxShadow(
//                                    color: Colors.pinkAccent[400],
//                                    offset: Offset(5, 5),
//                                    blurRadius: 2)
//                              ]),
//                          child: Icon(Icons.restaurant),
//                        ),
//                      ),
//                      Positioned(
//                        bottom: 15,
//                        left: 15,
//                        child: Text(
//                          'Nearby Restaurents',
//                          style: TextStyle(
//                              color: Colors.white,
//                              fontWeight: FontWeight.w600,
//                              fontSize: 14),
//                        ),
//                      )
//                    ],
//                  ),
//                  onTap: () {
//                    nextScreen(context, RestaurantPage(lat: lat, lng: lng));
//                  },
//                ),
            InkWell(
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.indigoAccent,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey, // Colors.grey[200],
                              offset: Offset(5, 5),
                              blurRadius: 2)
                        ]),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey, // Colors.indigoAccent[400],
                                offset: Offset(5, 5),
                                blurRadius: 2)
                          ]),
                      child: Icon(
                        LineIcons.comments,
                        size: 30,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    left: 15,
                    child: Text(
                      'User Reviews'.tr(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                  )
                ],
              ),
              onTap: () {
                if (Provider.of<UserBloc>(context, listen: false).getUid ==
                    null) {
                  openToast(context, 'Please do registration');
                  nextScreen(
                      context,
                      WellComePage(
                        isSkip: true,
                      ));
                  return;
                }
                nextScreen(
                    context,
                    CommentsPage(
                      title: 'User Reviews'.tr(),
                      timestamp: timestamp,
                    ));
              },
            ),
          ],
        ),
      )
    ],
  );
}
