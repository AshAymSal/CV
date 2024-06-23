import 'package:ecommernce/core/firebase_services.dart';
import 'package:ecommernce/features/map/location_page.dart';
import 'package:ecommernce/features/purchase/domain/entites/purchase.dart';
import 'package:ecommernce/features/purchase/presentation/bloc/purchase/purchase_cubit.dart';
import 'package:ecommernce/features/purchase/presentation/bloc/purchase/purchase_state.dart';
import 'package:ecommernce/features/purchase/presentation/pages/paypal_payment.dart';
import 'package:ecommernce/features/purchase/presentation/widgets/check_out_page/expandable_tile_widget.dart';
import 'package:ecommernce/features/purchase/presentation/widgets/check_out_page/pay_with_paypal_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckOutPage extends StatefulWidget {
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List items = [];
  late List<Purchase> pur;
  String quan = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: _appBar(),
        body: _body());
  }

  AppBar _appBar() {
    return AppBar(
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
    );
  }

  Widget _body() {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<PurchaseCubit, PurchaseState>(
                builder: (context, state) {
              /*if (state is LoadedPurchasesState) {  
                }
                return SizedBox();
                */
              return Text(
                "Total : \$" + state.total.toString(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              );
            }),
            SizedBox(height: 30),
            Text(
              "Items in your Cart",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Container(
                height: MediaQuery.of(context).size.height - 500,
                child: BlocBuilder<PurchaseCubit, PurchaseState>(
                    builder: (context, state) {
                  /*if (state is LoadedPurchasesState) {
                      return 
                    } else if (state is PurchasesInitial) {
                      return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: state.purchases.length,
                          itemBuilder: (context, index) {
                            pur = state.purchases;

                            return _buildExpandableTile(pur[index]);
                          });
                    }
                    return SizedBox();
                    */
                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: state.purchases.length,
                      itemBuilder: (context, index) {
                        pur = state.purchases;

                        return BuildExpandableTile(
                            purchase: pur[index], context: context, quan: quan);
                      });
                })),
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
            PayWithPaypalButton(context: context, items: items, pur: pur)
          ],
        ));
  }
}
