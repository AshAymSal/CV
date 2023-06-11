import 'package:ecommernce/model/product.dart';
import 'package:ecommernce/modules/detalis/detalisPage.dart';
import 'package:ecommernce/modules/oneProduct/oneProductProvider.dart';
import 'package:ecommernce/modules/signIn/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommernce/modules/signIn/signInProvider.dart';

class slOneProduct extends StatelessWidget {
  product? pro;
  slOneProduct(this.pro, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<oneProductProvider>(
          create: (_) {
            return (oneProductProvider());
          },
        ),
      ],
      child: sfOneProduct(pro),
    );
  }
}

class sfOneProduct extends StatefulWidget {
  product? pro;
  sfOneProduct(this.pro, {Key? key}) : super(key: key);

  @override
  State<sfOneProduct> createState() => stateOneProduct();
}

class stateOneProduct extends State<sfOneProduct> {
  void initState() {
    if (FirebaseAuth.instance.currentUser != null) {
      oneProductProvider
          .getRead(context)
          .isLiked(FirebaseAuth.instance.currentUser!.email!, widget.pro!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          height: 150,
          margin: EdgeInsets.symmetric(horizontal: 60),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                child: Row(
                  children: [
                    Container(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                          ),
                          child: Image.network(widget.pro!.images![0],
                              fit: BoxFit.fitHeight),
                        )),
                    //Spacer(),
                    Container(
                      width: 120,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            height: 50,
                            child: Container(
                                child: oneProductIcon(context, widget.pro!)),
                          ),
                          Container(
                            height: 20,
                            child: Center(
                                child: Text(
                              widget.pro!.name!,
                              style: TextStyle(fontSize: 16, fontFamily: "New"),
                            )),
                          ),
                          Container(
                            height: 50,
                            child: Center(
                                child: Text("\$" + widget.pro!.cost!,
                                    style: TextStyle(
                                        fontSize: 22, fontFamily: "New"))),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return slDetalis(
              widget.pro!,
              FirebaseAuth.instance.currentUser == null
                  ? '-1'
                  : FirebaseAuth.instance.currentUser!.email!);
        })).then((value) {
          if (FirebaseAuth.instance.currentUser != null) {
            oneProductProvider.getRead(context).isLiked(
                FirebaseAuth.instance.currentUser!.email!, widget.pro!);
          }
        });
      },
    );
  }
}

class slOneProductWidgetHomePage extends StatelessWidget {
  product? pro;
  slOneProductWidgetHomePage(this.pro, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<oneProductProvider>(
          create: (_) {
            return (oneProductProvider());
          },
        ),
      ],
      child: sfOneProductWidgetHomePage(pro),
    );
  }
}

class sfOneProductWidgetHomePage extends StatefulWidget {
  product? pro;
  sfOneProductWidgetHomePage(this.pro, {Key? key}) : super(key: key);

  @override
  State<sfOneProductWidgetHomePage> createState() =>
      stateOneProductWidgetHomePage();
}

class stateOneProductWidgetHomePage extends State<sfOneProductWidgetHomePage> {
  void initState() {
    if (FirebaseAuth.instance.currentUser != null) {
      oneProductProvider
          .getRead(context)
          .isLiked(FirebaseAuth.instance.currentUser!.email!, widget.pro!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return slDetalis(
              widget.pro!,
              FirebaseAuth.instance.currentUser == null
                  ? '-1'
                  : FirebaseAuth.instance.currentUser!.email!);
        })).then((value) {
          if (FirebaseAuth.instance.currentUser != null) {
            oneProductProvider.getRead(context).isLiked(
                FirebaseAuth.instance.currentUser!.email!, widget.pro!);
          }
        });
      },
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: 120,
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            child: Container(
              child: Column(
                children: [
                  Container(
                      height: 100,
                      width: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        ),
                        child: Image.network(widget.pro!.images![0],
                            fit: BoxFit.fill),
                      )),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    color: Colors.white,
                    height: 50,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                                width: 60,
                                child: Center(
                                    child: Text(
                                  widget.pro!.name!,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "New",
                                      fontSize: 11),
                                  textAlign: TextAlign.center,
                                ))),
                            SizedBox(height: 5),
                            Container(
                                width: 30,
                                child: Text(
                                  widget.pro!.cost! + "\$",
                                  style: TextStyle(
                                      fontSize: 12, fontFamily: "New"),
                                )),
                            //  SizedBox(width: 6),
                          ],
                        ),
                        Spacer(),
                        Container(
                          child: oneProductIcon(context, widget.pro!),
                          // alignment: Alignment.topRight,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

Widget oneProductIcon(BuildContext context, product pro) {
  return IconButton(
    icon: Icon(oneProductProvider.getWatch(context).icon,
        color: oneProductProvider.getWatch(context).iconColor),
    onPressed: () {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return signIn();
        }));
        return;
      }
      oneProductProvider.getRead(context).buttonPressed(
          context, FirebaseAuth.instance.currentUser!.email!, pro);
    },
  );
}
