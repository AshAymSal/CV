import 'package:ecommernce/modules/category/categoryProvider.dart';
import 'package:ecommernce/modules/category/categoryWidgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class slCategory extends StatelessWidget {
  String Catigory;
  slCategory(this.Catigory, {Key? key}) : super(key: key);
  @override
  Widget build(Object context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<categoryProvider>(
          create: (_) {
            return categoryProvider();
          },
        )
      ],
      child: sfCatigory(Catigory),
    );
  }
}

class sfCatigory extends StatefulWidget {
  String Catigory;
  sfCatigory(this.Catigory, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return catigoryState(Catigory);
  }
}

class catigoryState extends State<sfCatigory> {
  String? catigory;
  catigoryState(c) {
    catigory = c;
  }

  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height;
    final totalWidth = MediaQuery.of(context).size.width;
    CollectionReference ref1 =
        FirebaseFirestore.instance.collection("products");
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Color(0xffd3faff),
        child: Column(
          children: [
            Row(children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(
                      top: totalHeight / 8 / 2.5,
                      bottom: totalHeight / 120,
                      left: totalWidth / 40),
                  child: IconButton(
                    iconSize: 30,
                    icon: Icon(Icons.arrow_back_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ]),
            Container(
              child: Text(
                catigory!,
                style: TextStyle(fontSize: 25, fontFamily: "New"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                // color: Colors.red,
                height: MediaQuery.of(context).size.height - 156,
                child: whichCatigory(catigory!, context))
          ],
        ),
      ),
    );
  }
}
