import 'package:ecommernce/modules/favorites/favoriteWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/*class slFavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return sfFavoritePage();
  }
}

class sfFavoritePage extends StatefulWidget {
  sfFavoritePage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return stateFavoritePage();
  }
}

class stateFavoritePage extends State<sfFavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Favorites"),
      ),
      body: Container(
        //height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xffd3faff),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
                height: MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height -
                    40 -
                    34,
                color: Color(0xffd3faff),
                child: FirebaseAuth.instance.currentUser != null
                    ? favoriteListWidget(context)
                    : Center(
                        child: Text(
                        "You must to log in",
                        style: TextStyle(fontSize: 20),
                      )))
          ],
        ),
      ),
    );
  }
}
*/