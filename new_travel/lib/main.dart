// read the doc first, and then run

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:new_travel/blocs/blog_bloc.dart';
import 'package:new_travel/blocs/bookmark_bloc.dart';
import 'package:new_travel/blocs/comments_bloc.dart';
import 'package:new_travel/blocs/internet_bloc.dart';
import 'package:new_travel/blocs/place_bloc.dart';
import 'package:new_travel/blocs/popular_places_bloc.dart';
import 'package:new_travel/blocs/recent_places_bloc.dart';
import 'package:new_travel/blocs/recommanded_places_bloc.dart';
import 'package:new_travel/blocs/sign_in_bloc.dart';
import 'package:new_travel/blocs/user_bloc.dart';
import 'package:new_travel/pages/splash.dart';

import 'package:intl/date_symbol_data_local.dart' as intl_local_date_data;
import 'package:firebase_core/firebase_core.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  //print("ash");
  await intl_local_date_data.initializeDateFormatting();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: [
          Locale('lt'),
          Locale('en'),
          Locale('de'),
          Locale('ru')
        ],
        path: 'assets/translations', // <-- change patch to your
        fallbackLocale: Locale('lt'),
        child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: SplashPage());
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BlogBloc>(
          create: (context) => BlogBloc(),
        ),
        ChangeNotifierProvider<InternetBloc>(
          create: (context) => InternetBloc(),
        ),
        ChangeNotifierProvider<SignInBloc>(
          create: (context) => SignInBloc(),
        ),
        ChangeNotifierProvider<CommentsBloc>(
          create: (context) => CommentsBloc(),
        ),
        ChangeNotifierProvider<BookmarkBloc>(
          create: (context) => BookmarkBloc(),
        ),
        ChangeNotifierProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
        ChangeNotifierProvider<PlaceBloc>(
          create: (context) => PlaceBloc(),
        ),
        ChangeNotifierProvider<PopularPlacesBloc>(
          create: (context) => PopularPlacesBloc(),
        ),
        ChangeNotifierProvider<RecentPlacesBloc>(
          create: (context) => RecentPlacesBloc(),
        ),
        ChangeNotifierProvider<RecommandedPlacesBloc>(
          create: (context) => RecommandedPlacesBloc(),
        ),
      ],
      child: MaterialApp(
          theme: ThemeData(
              primarySwatch: Colors.blue,
              fontFamily: 'Muli',
              appBarTheme: AppBarTheme(
                color: Colors.white,
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                brightness:
                    Platform.isAndroid ? Brightness.dark : Brightness.light,
                textTheme: TextTheme(
                    headline6: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        fontFamily: 'Muli')),
              )),
          debugShowCheckedModeBanner: false,
          home: SplashPage()),
    );
  }
}
