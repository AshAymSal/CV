import 'package:apitest/models/user.dart';
import 'package:apitest/modules/signin/signInScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cache/AuthenticationProvider.dart';
import 'modules/home/drawer/friend requests/freindRequestsProvider.dart';
import 'modules/home/drawer/friends/friendsProvider.dart';
import 'modules/home/homeScreen.dart';
import 'cache/AuthenticationShardPreferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  await sharedPreferences.init();
//  runApp(MyApp());
  runApp(_checkAuth());
}

class _checkAuth extends StatelessWidget {
  const _checkAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => authProvider()..checkAuth(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => friendRequestsProvider(),
        ),
        ChangeNotifierProvider(
            create: (BuildContext context) => FriendsProvider()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Checking");
    userModel? user = authProvider.getWatch(context).user;
    //userModel? user = userModel();
    return MaterialApp(
        home: user == null ? slSignInScreen() : slhomeScreen(),
        debugShowCheckedModeBanner: false);
  }
}
