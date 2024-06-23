import 'package:ecommernce/features/purchase/presentation/bloc/order/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class oneColor extends StatefulWidget {
  String color;
  String size;
  TextEditingController textController = TextEditingController();
  var quantitiy = 0;
  oneColor(this.size, this.color, {Key? key}) : super(key: key);

  @override
  State<oneColor> createState() => _oneColorState();
}

class _oneColorState extends State<oneColor> {
  @override
  Widget build(BuildContext context) {
    print("one color state");
    //var color = int.parse('0xFF' + pro.colors![index]);
    var color = int.parse('0xFF' + widget.color);

    widget.textController.text = widget.quantitiy.toString();
    return Row(
      children: [
        GestureDetector(
          child: Container(
            height: 40,
            width: 30,
            decoration: BoxDecoration(
                //border:
                shape: BoxShape.circle,
                color: Color(color)),
          ),
          onTap: () {},
        ),
        Spacer(),
        Container(
            height: 30,
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    widget.quantitiy++;
                    var key = widget.size + '0xFF' + widget.color;
                    //print(key);
                    BlocProvider.of<OrderCubit>(context)
                        .editItems(key, widget.quantitiy.toString());
                    setState(
                      () {
                        widget.textController.text =
                            widget.quantitiy.toString();
                      },
                    );
                    //print("increase quan  " + quantitiy.toString());
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
                    child: TextField(
                      textAlign: TextAlign.center,
                      readOnly: true,
                      controller: widget.textController,
                    )),
                GestureDetector(
                  onTap: () {
                    if (widget.quantitiy <= 0) {
                      return;
                    }

                    widget.quantitiy--;
                    var key = widget.size + '0xFF' + widget.color;
                    BlocProvider.of<OrderCubit>(context)
                        .editItems(key, widget.quantitiy.toString());
                    setState(() {
                      widget.textController.text = widget.quantitiy.toString();
                    });
                  },
                  child: Icon(
                    Icons.arrow_circle_down,
                    size: 20,
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
