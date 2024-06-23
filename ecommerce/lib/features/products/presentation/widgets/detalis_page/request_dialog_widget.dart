import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/products/presentation/widgets/detalis_page/color_and_quantity_list_widget.dart';
import 'package:ecommernce/features/purchase/domain/entites/purchase.dart';
import 'package:ecommernce/features/purchase/presentation/bloc/order/order_cubit.dart';
import 'package:ecommernce/features/purchase/presentation/bloc/order/order_state.dart';
import 'package:ecommernce/features/purchase/presentation/bloc/purchase/purchase_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class slAlert extends StatelessWidget {
  Product pro;
  int selectedIndex;
  slAlert(this.selectedIndex, this.pro, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) {
        return OrderCubit();
      }),
    ], child: sfAlert(selectedIndex, pro));
    //sfAlert(selectedIndex,pro);
  }
}

class sfAlert extends StatefulWidget {
  Product pro;
  int selectedIndex;
  sfAlert(this.selectedIndex, this.pro, {Key? key}) : super(key: key);

  @override
  State<sfAlert> createState() => _sfAlertState();
}

class _sfAlertState extends State<sfAlert> {
  @override
  Widget build(BuildContext context) {
    var colors = widget.pro.colors!;
    List<colorsAndQuantityList> widgetss = [];
    for (int i = 0; i < widget.pro.sizes!.length; i++) {
      widgetss.add(colorsAndQuantityList(widget.pro.sizes![i], colors));
    }
    print(widgetss.length);
    return AlertDialog(
      elevation: 0,
      title: Text("Confirm Adding"),
      content: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                //color: Colors.amber,
                height: 30,
                width: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.pro.sizes!.length,
                  itemBuilder: (BuildContext context, int index) {
                    // print("asdasd" + widgetss.length.toString());

                    return GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: widget.selectedIndex == index
                              ? Border.all(color: Colors.blue, width: 2)
                              : null,
                        ),
                        height: 40,
                        width: 40,
                        child: Text(
                          widget.pro.sizes![index],
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      onTap: () {
                        widget.selectedIndex = index;

                        setState(
                          () {},
                        );
                        print(widget.selectedIndex);
                        // print(widgetss[selectedIndex]);
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.grey,
                ),
                height: 1,
                width: 100,
              ),
              SizedBox(height: 20),
              IndexedStack(
                index: widget.selectedIndex,
                children: widgetss,
              ),
              Text("asd")
            ],
          );
        },
      ),
      actions: [
        OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("no")),
        OutlinedButton(
            onPressed: () async {
              var s = BlocProvider.of<OrderCubit>(context).state as OrderState;

              Map rs = s.items;
              int totalQuantity = 0;
              rs.forEach((key, value) {
                totalQuantity += int.parse(value);
              });
              // print(totalQuantity);
              Purchase p = Purchase(
                  p: widget.pro,
                  quantity: totalQuantity.toString(),
                  detalis: rs);
              BlocProvider.of<PurchaseCubit>(context).addToPurchase(p);
              BlocProvider.of<PurchaseCubit>(context)
                  .addToTotal(int.parse(p.p!.cost!) * int.parse(p.quantity!));
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Done")));

              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text("yes")),
      ],
    );
  }
}
