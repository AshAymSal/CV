import 'package:ecommernce/features/purchase/domain/entites/purchase.dart';
import 'package:ecommernce/model/product.dart';
import 'package:ecommernce/model/purchase.dart';
import 'package:flutter/material.dart';

Widget SaleItem(
    BuildContext context, double totalHeight, double totalWidth, Purchase pur) {
  //print(pro.daydate! + " z " + pro.daytime.toString());
  return GestureDetector(
    child: Container(
        height: totalHeight / 8,
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 20),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              child: Row(
                children: [
                  Container(
                      width: totalWidth / 4,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                        ),
                        child:
                            Image.network(pur.p!.images![0], fit: BoxFit.fill),
                      )),
                  Container(
                    width: totalWidth / 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Center(
                              child: Text(
                            "${pur.p!.name!}",
                            style: TextStyle(fontSize: 12, fontFamily: "New"),
                          )),
                        ),
                        Container(
                          child: Center(
                              child: Text(
                            "${pur.quantity}",
                            style: TextStyle(fontSize: 12, fontFamily: "New"),
                          )),
                        ),
                        Container(
                          child: Center(
                              child: Text("\$" + pur.p!.cost!,
                                  style: TextStyle(
                                      fontSize: 13, fontFamily: "New"))),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2 / 3 * 2 - 9,
                    child: Column(
                      children: [
                        Container(
                          height: totalHeight / 20,
                          child: Center(
                              child: Text(
                            pur.p!.daydate!,
                            style: TextStyle(fontSize: 12, fontFamily: "New"),
                          )),
                        ),
                        Container(
                          height: totalHeight / 20,
                          child: Center(
                              child: Text(pur.p!.daytime!,
                                  style: const TextStyle(
                                      fontSize: 12, fontFamily: "New"))),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )),
    onTap: () {},
  );
}
