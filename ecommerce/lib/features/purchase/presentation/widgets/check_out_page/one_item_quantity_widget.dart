import 'package:ecommernce/features/purchase/presentation/pages/check_out_page.dart';
import 'package:ecommernce/features/purchase/presentation/widgets/check_out_page/cross_out_container.dart';
import 'package:flutter/material.dart';

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
