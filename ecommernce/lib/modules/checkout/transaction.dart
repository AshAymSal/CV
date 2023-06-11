import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommernce/firebase.dart';
import 'package:ecommernce/model/purchase.dart';
import 'package:ecommernce/modules/checkout/payment.dart';
import 'package:ecommernce/modules/checkout/puchaseProvider.dart';
import 'package:ecommernce/modules/location/locationPage.dart';
import 'package:ecommernce/modules/sales/salesProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ecommernce/modules/signIn/signInProvider.dart';

class Transaction extends StatefulWidget {
  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  /*List items = [
    {'name': 'iPhone 7', 'quantity': '1', 'price': '200'},
    {'name': 'iPhone 12', 'quantity': '2', 'price': '1400'}
  ];*/
  List items = [];
  late List<purchase> pur;
  String quan = "";
  // int total = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*List pur = purchaseProvider.getRead(context).getPurchase();
    for (purchase p in pur) {
      var item = {
        'name': p.p!.name!,
        'quantity': p.quantity,
        'price': p.p!.cost,
        'url': p.p!.url,
      };
      items.add(item);
      total += int.parse(p.p!.cost!) * int.parse(p.quantity!);
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        //backgroundColor: Colors.white,
        title: Text(
          'Paypal Payment',
          style: TextStyle(
            fontSize: 18.0,
            // color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Total : \$" +
                    purchaseProvider.getWatch(context).total.toString(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 30),
              Text(
                "Items in your Cart",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 500,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount:
                        purchaseProvider.getWatch(context).purchases.length,
                    itemBuilder: (context, index) {
                      pur = purchaseProvider.getWatch(context).purchases;

                      return _buildExpandableTile(pur[index]);
                    }),
              ),
              Text("Your region"),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => SimpleMap()));
                  },
                  child: Text("select your region")),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('lat'),
                  Container(width: 100, child: TextField()),
                  Text('lang'),
                  Container(width: 100, child: TextField()),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                //color: Colors.red,
                onPressed: () {
                  // make PayPal payment
                  for (purchase p in pur) {
                    var item = {
                      'name': p.p!.name!,
                      'quantity': p.quantity,
                      'price': p.p!.cost,
                      'url': p.p!.images![0],
                    };
                    items.add(item);
                    /*purchaseProvider.getRead(context).addToTotal(
                                int.parse(p.p!.cost!) *
                                    int.parse(p.quantity!));*/
                  }

                  Navigator.of(context)
                      .push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => Payment(
                        items: items,
                        onFinish: (number) async {
                          // payment done
                          print("DDDDOOOONNNEEE");

                          final snackBar = SnackBar(
                            content: Text("Payment done Successfully"),
                            duration: Duration(seconds: 5),
                            action: SnackBarAction(
                              label: 'Close',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );
                          // _scaffoldKey.currentState
                          // !
                          //.showSnackBar(snackBar);
                          print('order id: ' + number);
                          print('ddasdas');
                        },
                      ),
                    ),
                  )
                      .then((value) {
                    firebaseServices().addToProfits(pur);
                    firebaseServices().increaseTimes(pur);
                    firebaseServices().addToSales(
                        FirebaseAuth.instance.currentUser!.email!, pur);
                  }).then((value) {
                    purchaseProvider.getRead(context).clearPurchase();
                  });
                },
                child: Text(
                  'Pay with Paypal',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildExpandableTile(purchase pur) {
    List<Widget> detalisWidgets = [];
    detalisWidgets.add(ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 60),
      leading: Text('Color'),
      title: Text('Size'),
      trailing: Text('Quantity'),
    ));
    pur.dtalis!.forEach((key, value) {
      detalisWidgets.add(ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 60),
        title: Text(key.toString().substring(0, 2)),
        leading: Container(
          height: 40,
          width: 30,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(int.parse(key.toString().substring(2)))),
        ),
        trailing: Text(value),
      ));
    });
    return ExpansionTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.keyboard_arrow_right_outlined),
            Container(
                width: 40,
                height: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                  ),
                  child:
                      Image.network(pur.p!.images![0], fit: BoxFit.fitHeight),
                )),
          ],
        ),
        title: Text(
          "Product: " + pur.p!.name!,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          "Quantity: " + pur.quantity!,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "\$" + pur.p!.cost!.toString(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(width: 10),
            GestureDetector(
                child: Icon(
                  Icons.edit,
                  color: Colors.cyan,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      List<oneItemQuantity> ll = [];
                      pur.dtalis!.forEach((key, value) {
                        ll.add(oneItemQuantity(
                            key,
                            int.parse(key.toString().substring(2)),
                            key.toString().substring(0, 2),
                            value));
                      });
                      quan = pur.quantity!;
                      return AlertDialog(
                        title: Text("Edit Quantity"),
                        content:
                            StatefulBuilder /*to make setstate inside showDaialog possiple*/ (
                                builder: ((context, setState) {
                          return /*Row(mainAxisSize: MainAxisSize.min, children: [
                            GestureDetector(
                              onTap: () {
                                int now = int.parse(quan);
                                int after = now + 1;

                                setState(() {
                                  quan = after.toString();
                                });
                                print(quan);
                              },
                              child: Icon(Icons.arrow_circle_up),
                            ),
                            SizedBox(width: 10),
                            Text(quan),
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                int now = int.parse(quan);
                                if (now == 1) {
                                  return;
                                }
                                int after = now - 1;
                                setState(() {
                                  quan = after.toString();
                                });
                              },
                              child: Icon(Icons.arrow_circle_down),
                            )
                          ]);*/
                              Column(
                            mainAxisSize: MainAxisSize.min,
                            children: ll,
                          );
                        })),
                        actions: [
                          OutlinedButton(
                              onPressed: () async {
                                purchaseProvider
                                    .getRead(context)
                                    .editQuantity(pur, ll);

                                Navigator.pop(context);
                              },
                              child: Text("Done")),
                        ],
                      );
                    },
                  );
                }),
            SizedBox(width: 10),
            GestureDetector(
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Remove Item"),
                        content: Text("Do You Want To Remove This Item"),
                        actions: [
                          OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("no")),
                          OutlinedButton(
                              onPressed: () async {
                                purchaseProvider
                                    .getRead(context)
                                    .minusFromTotal(int.parse(pur.p!.cost!) *
                                        int.parse(pur.quantity!));
                                purchaseProvider
                                    .getRead(context)
                                    .removeItem(pur);

                                Navigator.pop(context);
                              },
                              child: Text("yes")),
                        ],
                      );
                    },
                  );
                }),
          ],
        ),
        children: detalisWidgets);
  }
}

class oneItemQuantity extends StatefulWidget {
  var color;
  var size;
  var quantity;
  var keyMap;
  bool isDeleted = false;
  oneItemQuantity(this.keyMap, this.color, this.size, this.quantity, {Key? key})
      : super(key: key);

  @override
  State<oneItemQuantity> createState() => _oneItemQuantityState();
}

class _oneItemQuantityState extends State<oneItemQuantity> {
  @override
  Widget build(BuildContext context) {
    return CrossedOutContainer(
      ListTile(
        leading: Container(
          height: 40,
          width: 30,
          decoration: BoxDecoration(

              //border:
              shape: BoxShape.circle,
              color: Color(widget.color)),
        ),
        title: Text(
          widget.size,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                int quan = int.parse(widget.quantity);
                quan++;
                setState(() {
                  widget.quantity = quan.toString();
                });
              },
              child: Icon(
                Icons.arrow_circle_up,
                size: 20,
              ),
            ),
            Container(
                alignment: Alignment.center,
                height: 30,
                width: 30,
                child: Text(widget.quantity)),
            GestureDetector(
              onTap: () {
                int quan = int.parse(widget.quantity);
                if (quan == 1) {
                  return;
                }
                quan--;
                setState(() {
                  widget.quantity = quan.toString();
                });
              },
              child: Icon(
                Icons.arrow_circle_down,
                size: 20,
              ),
            ),
            SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.isDeleted = !widget.isDeleted;
                  // print(widget.isDeleted);
                });
              },
              child: Icon(
                Icons.delete,
                color: Colors.red,
                size: 20,
              ),
            ),
          ],
        ),
      ),
      widget.isDeleted,
    );
  }
}

class CrossedOutContainer extends StatelessWidget {
  Widget child;
  bool isDeleted;

  CrossedOutContainer(this.child, this.isDeleted, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CrossedOutPainter(isDeleted),
      child: Container(
        child: child,
      ),
    );
  }
}

class _CrossedOutPainter extends CustomPainter {
  bool isDeleted;
  _CrossedOutPainter(this.isDeleted);
  @override
  void paint(Canvas canvas, Size size) {
    if (isDeleted) {
      Paint paint = Paint()
        ..color = Colors.red
        ..strokeWidth = 2.0;

      canvas.drawLine(
        Offset(0, size.height / 2),
        Offset(size.width, size.height / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
