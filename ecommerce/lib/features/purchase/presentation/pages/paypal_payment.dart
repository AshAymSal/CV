import 'dart:core';
import 'package:ecommernce/core/network/network_info.dart';
import 'package:ecommernce/core/api_services.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Payment extends StatefulWidget {
  final Function onFinish;
  final List items;

  Payment({required this.onFinish, required this.items});

  @override
  State<StatefulWidget> createState() {
    return PaymentState();
  }
}

class PaymentState extends State<Payment> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? checkoutUrl;
  String? executeUrl;
  String? accessToken;
  Services services = Services();

  // you can change default currency according to your need
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "USD ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "USD"
  };

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL = 'cancel.example.com';

  //String itemName = 'iPhone 7';
  //String itemPrice = '200';
  //int quantity = 1;

  Map<String, dynamic> getOrderParams() {
    /*List items = [
      {
        "name": itemName,
        "quantity": quantity,
        "price": itemPrice,
        "currency": defaultCurrency["currency"]
      }
    ];*/

    List items = widget.items;

    int t = 0;
    for (var n in items) {
      int no = int.parse(n['quantity']);
      t += int.parse(n['price']) * no;
      n['currency'] = defaultCurrency["currency"];
    }
    String totalAmount = t.toString();
    //String subTotalAmount = t.toString();

    /*List items = [
      {
        "name": 'iphone',
        "quantity": '1',
        "price": '200',
        "currency": defaultCurrency["currency"]
      }
    ];
    String totalAmount = '200';
    String subTotalAmount = '200';*/

    String shippingCost = '0';
    int shippingDiscountCost = 0;
    String userFirstName = 'Arsalan';
    String userLastName = 'Umar';
    String addressCity = 'Islamabad';
    String addressStreet = "i-10";
    String addressZipCode = '44000';
    String addressCountry = 'Pakistan';
    String addressState = 'Islamabad';
    String addressPhoneNumber = '+923200811288';

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": totalAmount,
            "currency": defaultCurrency["currency"],
            "details": {
              //"subtotal": subTotalAmount,
              "shipping": shippingCost,
              "shipping_discount": ((-1.0) * shippingDiscountCost).toString()
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {
            "items": items,
            if (isEnableShipping && isEnableAddress)
              "shipping_address": {
                "recipient_name": userFirstName + " " + userLastName,
                "line1": addressStreet,
                "line2": "",
                "city": addressCity,
                "country_code": addressCountry,
                "postal_code": addressZipCode,
                "phone": addressPhoneNumber,
                "state": addressState
              },
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
    return temp;
  }

  var controller;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      try {
        accessToken = await services.getAccessToken();

        final transactions = getOrderParams();
        final res =
            await services.createPaypalPayment(transactions, accessToken);
        if (res != null) {
          setState(() {
            checkoutUrl = res["approvalUrl"];
            executeUrl = res["executeUrl"];
          });
        }
      } catch (e) {
        print('exception: ' + e.toString());
        final snackBar = SnackBar(
          content: Text(e.toString()),
          duration: Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        //_scaffoldKey.currentState!.showSnackBar(snackBar);
      }
    }).then((value) {
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
            },
            onPageStarted: (String url) {},
            onPageFinished: (String url) {},
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.contains(returnURL)) {
                print("request url ::" + request.url);
                final uri = Uri.parse(request.url);
                final payerID = uri.queryParameters['PayerID'];
                if (payerID != null) {
                  services
                      .executePayment(executeUrl, payerID, accessToken!)
                      .then((id) {
                    widget.onFinish(id);
                    Navigator.of(context).pop();
                  });
                } else {
                  Navigator.of(context).pop();
                }
                //Navigator.of(context).pop();
              }
              if (request.url.contains(cancelURL)) {
                Navigator.of(context).pop();
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(checkoutUrl!));
      print(checkoutUrl!);
    });
  }

  // item name, price and quantity

  @override
  Widget build(BuildContext context) {
    print(checkoutUrl);

    if (checkoutUrl != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: WebViewWidget(
          controller: controller,
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.black12,
          elevation: 0.0,
        ),
        body: Center(child: Container(child: CircularProgressIndicator())),
      );
    }
  }
}
