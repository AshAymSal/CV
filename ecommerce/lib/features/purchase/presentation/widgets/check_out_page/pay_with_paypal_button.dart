import 'package:ecommernce/core/firebase_services.dart';
import 'package:ecommernce/features/purchase/domain/entites/purchase.dart';
import 'package:ecommernce/features/purchase/presentation/bloc/purchase/purchase_cubit.dart';
import 'package:ecommernce/features/purchase/presentation/pages/paypal_payment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget PayWithPaypalButton(
    {required List<Purchase> pur,
    required BuildContext context,
    required List items}) {
  return ElevatedButton(
    //color: Colors.red,
    onPressed: () {
      for (Purchase p in pur) {
        var item = {
          'name': p.p!.name!,
          'quantity': p.quantity,
          'price': p.p!.cost,
          'url': p.p!.images![0],
        };
        items.add(item);
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
        firebaseServices()
            .addToSales(FirebaseAuth.instance.currentUser!.email!, pur);
      }).then((value) {
        BlocProvider.of<PurchaseCubit>(context).clearPurchase();
      });
    },
    child: Text(
      'Pay with Paypal',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white),
    ),
  );
}
