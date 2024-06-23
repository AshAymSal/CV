import 'package:ecommernce/features/purchase/domain/entites/purchase.dart';
import 'package:ecommernce/features/purchase/presentation/bloc/purchase/purchase_cubit.dart';
import 'package:ecommernce/features/purchase/presentation/widgets/check_out_page/one_item_quantity_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget BuildExpandableTile(
    {required Purchase purchase,
    required BuildContext context,
    required String quan}) {
  List<Widget> detalisWidgets = [];
  detalisWidgets.add(ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 60),
    leading: Text('Color'),
    title: Text('Size'),
    trailing: Text('Quantity'),
  ));
  purchase.detalis!.forEach((key, value) {
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
                child: Image.network(purchase.p!.images![0],
                    fit: BoxFit.fitHeight),
              )),
        ],
      ),
      title: Text(
        "Product: " + purchase.p!.name!,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        "Quantity: " + purchase.quantity!,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "\$" + purchase.p!.cost!.toString(),
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
                    purchase.detalis!.forEach((key, value) {
                      ll.add(oneItemQuantity(
                          key,
                          int.parse(key.toString().substring(2)),
                          key.toString().substring(0, 2),
                          value));
                    });
                    quan = purchase.quantity!;
                    return AlertDialog(
                      title: Text("Edit Quantity"),
                      content:
                          StatefulBuilder /*to make setstate inside showDaialog possiple*/ (
                              builder: ((context, setState) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: ll,
                        );
                      })),
                      actions: [
                        OutlinedButton(
                            onPressed: () async {
                              BlocProvider.of<PurchaseCubit>(context)
                                  .editQuantity(purchase, ll);

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
                              BlocProvider.of<PurchaseCubit>(context)
                                  .minusFromTotal(int.parse(purchase.p!.cost!) *
                                      int.parse(purchase.quantity!));
                              BlocProvider.of<PurchaseCubit>(context)
                                  .removeFromPurchase(purchase);

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
