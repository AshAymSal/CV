import 'package:ecommernce/features/products/presentation/widgets/detalis_page/one_color_widget.dart';
import 'package:ecommernce/features/purchase/presentation/bloc/order/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class slcolorsAndQuantityList extends StatelessWidget {
  var size;
  var colors;
  slcolorsAndQuantityList(this.size, this.colors, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) {
        return OrderCubit();
      }),
    ], child: colorsAndQuantityList(size, colors));
  }
}

class colorsAndQuantityList extends StatefulWidget {
  var size;
  var colors;

  colorsAndQuantityList(this.size, this.colors, {Key? key}) : super(key: key);

  @override
  State<colorsAndQuantityList> createState() => colorsAndQuantityListState();
}

class colorsAndQuantityListState extends State<colorsAndQuantityList> {
  @override
  Widget build(BuildContext context) {
    print("colorsAndQuantityListState state");
    return Container(
      //alignment: Alignment.topLeft,
      //color: Colors.amber,
      height: 200,
      width: 200,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.colors!.length,
        itemBuilder: (BuildContext context, int index) {
          var color = int.parse('0xFF' + widget.colors![index]);
          return oneColor(widget.size, widget.colors![index]);
        },
      ),
    );
  }
}
