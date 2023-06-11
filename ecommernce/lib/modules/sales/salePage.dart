import 'package:ecommernce/model/purchase.dart';
import 'package:ecommernce/modules/sales/saleItems.dart';
import 'package:ecommernce/modules/sales/salesProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class slSalePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<salesProvider>(
          create: (_) {
            return (salesProvider());
          },
        ),
      ],
      child: sfSalePage(),
    );
  }
}

class sfSalePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return stateSalePage();
  }
}

class stateSalePage extends State<sfSalePage> {
  late List<purchase> sales;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      salesProvider
          .getRead(context)
          .getSales(FirebaseAuth.instance.currentUser!.email!);
    }

    sales = salesProvider.getWatch(context).sales;
    //print(sales.length);

    final totalHeight = MediaQuery.of(context).size.height;
    final totalWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Sales History"),
        ),
        body: Container(
          height: totalHeight,
          width: totalWidth,
          color: Color(0xffd3faff),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Container(
                height: totalHeight / 1.249,
                child: FirebaseAuth.instance.currentUser != null
                    ? ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: sales.length,
                        itemBuilder: (context, index) {
                          final pur = sales[index];

                          return saleItems(
                            context,
                            totalHeight,
                            totalWidth,
                            pur,
                          );
                        })
                    : Center(
                        child: Text(
                        "You must to log in",
                        style: TextStyle(fontSize: 20),
                      )),
              ),
            ],
          ),
        ));
  }
}
