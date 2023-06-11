import 'package:business/connectivity_service.dart';
import 'package:business/core/network/local/shared_preferences_service.dart';
import 'package:business/view/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/local/cache_helper.dart';
import 'core/network/remote/api_request.dart';
import 'core/services/firebase_messaging_service.dart';
//Test Mina
// keytool -genkey -v -keystore /Users/usama/Projects/flutter/freelance/Kalied/business/android/busniess.jks -keyalg RSA -keysize 2048 -validity 10000 -alias busniess
// keytool -list -v -keystore /Users/usama/Projects/flutter/freelance/Kalied/business/android/busniess.jks -alias busniess -storepass busniess -keypass busniess

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ApiRequest.init();
  await CacheHelper.init();
  await getApplicationDocumentsDirectory();
  ConnectivityService.instance.initializeConnectivityListeners();
  final sharedPreferences = await SharedPreferences.getInstance();
  await FirebaseNotifications.instance.setUpListeners();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesServiceProvider.overrideWithValue(
          SharedPreferencesService(sharedPreferences),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Cairo',
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: SafeArea(child: SplashView()),
        );
      },
    );
  }
}
