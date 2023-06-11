import 'package:ecommernce/firebase.dart';
import 'package:ecommernce/modules/checkout/puchaseProvider.dart';
import 'package:ecommernce/modules/favorites/favoriteProvider.dart';
import 'package:ecommernce/modules/sales/salesProvider.dart';
import 'package:ecommernce/modules/settings/customDrawer.dart';
import 'package:ecommernce/modules/settings/settingsPage.dart';
import 'package:ecommernce/modules/signIn/signInProvider.dart';
import 'package:ecommernce/modules/signIn/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'mainPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ecommernce/cache/sharedPreferences.dart';

Future<void> main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await sharedPreferences.init();
  runApp(slRunApp());
}

class slRunApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<firebase>(
        create: (_) {
          return firebase();
        },
      ),
      /*ChangeNotifierProvider<signInProvider>(
        create: (_) {
          return signInProvider();
        },
      ),*/
      Provider<signInProvider>(
        create: (_) {
          return signInProvider(FirebaseAuth.instance);
        },
      ),
      StreamProvider(
        create: (context) {
          return context.read<signInProvider>().authStateChenges;
        },
        initialData: null,
      ),
      ChangeNotifierProvider<purchaseProvider>(
        create: (_) {
          return purchaseProvider();
        },
      ),
      ChangeNotifierProvider<favoriteProvider>(
        create: (_) {
          return favoriteProvider();
        },
      ),
    ], child: MaterialApp(home: slUser(), debugShowCheckedModeBanner: false));
  }
}

class slUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    /*if (firebaseUser == null) {
      return signIn();
    }*/
    return CustomDrawer(
      //controller: _drawerController,
      //mainScreen: slMainPage(_drawerController),
      //menuScreen: slSettingsPage(_drawerController),
      showShadow: false,
      angle: 0.0,
      borderRadius: 30,
      slideWidth: MediaQuery.of(context).size.width *
          (CustomDrawer.isRTL(context) ? 0.45 : 0.70),
    );
    //return slMainPage();
  }
}
