import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:new_travel/blocs/blog_bloc.dart';
import 'package:new_travel/blocs/bookmark_bloc.dart';
import 'package:new_travel/blocs/place_bloc.dart';
import 'package:new_travel/blocs/user_bloc.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:new_travel/models/config.dart';
import 'package:new_travel/pages/guide.dart';
import 'package:new_travel/pages/profile.dart';
import 'package:new_travel/pages/search.dart';
import 'package:new_travel/utils/next_screen.dart';
import 'package:new_travel/widgets/featured_places.dart';

import 'package:new_travel/widgets/popular_places.dart';
import 'package:new_travel/widgets/recent_places.dart';
import 'package:new_travel/widgets/recommended_places.dart';

import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userName, userEmail;

  String userProfilePic = '';
  int listIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 0)).then((_) {
      final UserBloc ub = Provider.of<UserBloc>(context, listen: false);
      final PlaceBloc pb = Provider.of<PlaceBloc>(context, listen: false);
      final BlogBloc bgb = Provider.of<BlogBloc>(context, listen: false);
      final BookmarkBloc bb = Provider.of<BookmarkBloc>(context, listen: false);

      ub.getUserData();
      pb.getLovedList();
      pb.getBookmarkedList();
      bgb.getLovedList();
      bgb.getBookmarkedList();
      bb.getBlogData();
      bb.getPlaceData();
    });
  }

  Widget searchBar(w) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 5),
      child: InkWell(
        child: Container(
          alignment: Alignment.centerLeft,
          height: 43,
          width: w,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: Colors.grey, //Colors.grey[400],
                width: 0.5),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Icon(CupertinoIcons.search),
                SizedBox(
                  width: 20,
                ),
                Text('Search Places & Explore'.tr()),
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchPage()));
        },
      ),
    );
  }

  Widget header(w) {
    final UserBloc ub = Provider.of<UserBloc>(context);

    return Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 20),
        child: SizedBox(
          height: 55,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    Config().appName,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Colors.grey[700]),
                  ),
                  Text(
                    '${Config().countryName}',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600]),
                  )
                ],
              ),
              IconButton(
                  icon: Icon(
                    Icons.place,
                    size: 30,
                    color: Colors.grey[700],
                  ),
                  onPressed: () {
                    nextScreen(
                        context,
                        GuidePage(
                          lat: 54.7747169,
                          lng: 24.4057835,
                          placeName: "",
                          zoom: 10,
                        ));
                  }),
              Spacer(),
              InkWell(
                child: ub.imageUrl == null
                    ? Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.person, size: 28),
                      )
                    : Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image:
                                    CachedNetworkImageProvider("ub.imageUrl!"),
                                fit: BoxFit.cover)),
                      ),
                onTap: () {
                  nextScreen(context, ProfilePage());
                },
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          //backgroundColor: Colors.white,
          body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            header(w),
            searchBar(w),
            SizedBox(
              height: 10,
            ),
            Featured(),
            PopularPlaces(),
            RecentPlaces(),
            RecommendedPlaces()
          ],
        ),
      )),
    );
  }
}
