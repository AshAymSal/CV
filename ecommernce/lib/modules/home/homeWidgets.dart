import 'package:ecommernce/model/product.dart';
import 'package:ecommernce/modules/category/categoryPage.dart';
import 'package:ecommernce/modules/checkout/transaction.dart';
import 'package:ecommernce/modules/detalis/detalisPage.dart';
import 'package:ecommernce/modules/home/homePage.dart';
import 'package:ecommernce/modules/oneProduct/oneProductWidgets.dart';
import 'package:ecommernce/modules/signIn/signInProvider.dart';
import 'package:ecommernce/modules/signIn/signin.dart';
import 'package:flutter/material.dart';
import 'package:ecommernce/modules/home/homeProvider.dart';

Widget Catigory(BuildContext context, String a, String b) {
  return Container(
      width: MediaQuery.of(context).size.width / 4,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return slCategory(a);
          }));
        },
        child: Card(
          child: Column(
            children: [
              Container(
                  width: 95,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: Image.network(b,
                        width: 95, height: 120, fit: BoxFit.fill),
                  )),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(a,
                    style: TextStyle(
                        color: Colors.white, fontFamily: "New", fontSize: 13)),
              )
            ],
          ),
          color: Colors.blueAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ));
}

Widget signOutButton(Function signOut) {
  return ElevatedButton(
    child: Row(
      children: [
        Icon(Icons.logout),
        Text(
          "  Sign out",
          style: TextStyle(fontFamily: "New"),
        ),
      ],
    ),
    onPressed: () {
      signOut();
    },
  );
}

Widget signInButton(Function signIn) {
  return ElevatedButton(
    child: Row(
      children: [
        Icon(Icons.login),
        Text(
          "  Sign In",
          style: TextStyle(fontFamily: "New"),
        ),
      ],
    ),
    onPressed: () {
      signIn();
    },
  );
}

Widget checkOutButton(BuildContext context) {
  return ElevatedButton(
    child: Row(
      children: [
        Icon(Icons.attach_money),
        Text(
          " Check out",
          style: TextStyle(fontFamily: "New"),
        ),
      ],
    ),
    onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Transaction();
      }));
      //signOut;
    },
  );
}

Widget mostPupularList(BuildContext context) {
  return Container(
      height: 150,
      child: FutureBuilder<List>(
        future: homeProvider.getRead(context).getPopular(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              List mostPopular = homeProvider.getRead(context).mostPopular;

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: mostPopular.length,
                itemBuilder: (BuildContext context, int index) {
                  product pro = mostPopular[index];
                  return slOneProductWidgetHomePage(pro);
                },
              );
          }
        },
      ));
}
