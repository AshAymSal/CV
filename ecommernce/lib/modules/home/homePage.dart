import 'package:ecommernce/modules/home/homeProvider.dart';
import 'package:ecommernce/modules/home/homeWidgets.dart';
import 'package:ecommernce/modules/search/searchPage.dart';
import 'package:ecommernce/modules/signIn/signInProvider.dart';
import 'package:ecommernce/modules/signIn/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';

class slhomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (BuildContext context) {
            return homeProvider();
          },
        ),
      ],
      child: sfhomepage(),
    );
  }
}

class sfhomepage extends StatefulWidget {
  sfhomepage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return statehomepage();
  }
}

class statehomepage extends State<sfhomepage> {
  //late List mostPopular;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 60,
      color: Color(0xffd3faff),
      child: Column(
        children: [
          //SizedBox(height: 100,),
          Container(
              // color: Colors.blue,
              height: 100,
              padding: EdgeInsets.only(top: 50, left: 10, right: 10),
              child: Text(
                "Ecommernce",
                style: TextStyle(
                  fontSize: 20,
                ),
              )

              /*Row(
              children: [
                FirebaseAuth.instance.currentUser != null
                    ? signOutButton(() {
                        signInProvider.getRead(context).signOut().then((_) {
                          Restart.restartApp();
                        });
                      })
                    : signInButton(() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return signIn();
                        }));
                      }),
                Spacer(),
                checkOutButton(context)
              ],
            ),*/
              ),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              // color: Colors.white,
              width: 400,
              child: Row(
                children: [
                  Container(
                    width: 300,
                    height: 50,
                  ),
                  Spacer(),
                  Icon(Icons.search)
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return slSearch();
              }));
            },
          ),
          /*Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 150,
            width: 500,
            padding: EdgeInsets.all(15),
            child:
             Container(
                padding: EdgeInsets.only(top: 45, left: 20),
                child: Text(
                  "E-Commernce App",
                  style: TextStyle(
                      color: Colors.black, fontSize: 25, fontFamily: "New"),
                )),
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(20),
            ),
          ),*/
          SizedBox(
            height: 30,
          ),
          Container(
            child: Text(
              "   Catigories",
              style: TextStyle(fontSize: 20, fontFamily: "New"),
            ),
            padding: EdgeInsets.only(right: 260),
          ),
          SizedBox(
            height: 30,
          ),
          Row(children: [
            SizedBox(
              width: 0,
            ), //Jackets // https://5.imimg.com/data5/NM/LX/MY-42532489/mens-black-jacket-500x500.jpg
            Catigory(context, "Jackets",
                "https://5.imimg.com/data5/NM/LX/MY-42532489/mens-black-jacket-500x500.jpg"),
            SizedBox(
              width: 0,
            ),
            Catigory(context, "T-Shirts",
                "https://img1.g-star.com/product/c_fill,f_auto,h_630,q_80/v1614686111/D14143-336-6484-M05/g-star-raw-raw-graphic-slim-t-shirt-black.jpg"),
            SizedBox(
              width: 0,
            ), // Jeans // https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgxTAikYMr7EqAyPmAQHS73iqcTAc4vGCNGQ&usqp=CAU
            Catigory(context, "Jeans",
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgxTAikYMr7EqAyPmAQHS73iqcTAc4vGCNGQ&usqp=CAU"),
            SizedBox(
              width: 0,
            ), // Boots // https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKPx_Mkte5IqHtFMkU6pXUV_mMkBlE9hSEsg&usqp=CAU
            Catigory(context, "Boots",
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKPx_Mkte5IqHtFMkU6pXUV_mMkBlE9hSEsg&usqp=CAU"),
          ]),
          SizedBox(
            height: 30,
          ),
          Container(
            child: Text(
              "Most Popular",
              style: TextStyle(fontSize: 18, fontFamily: "New"),
            ),
            padding: EdgeInsets.only(right: 225),
          ),
          SizedBox(
            height: 30,
          ),
          mostPupularList(context)
        ],
      ),
    );
  }
}
