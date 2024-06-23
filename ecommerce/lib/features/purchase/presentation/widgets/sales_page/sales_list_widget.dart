import 'package:ecommernce/features/purchase/domain/entites/purchase.dart';
import 'package:ecommernce/features/purchase/presentation/widgets/sales_page/sale_item.dart';
import 'package:flutter/material.dart';

Widget SalesListWidget(totalWidth, totalHeight,
    {required List<Purchase> sales}) {
  return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: sales.length,
      itemBuilder: (context, index) {
        final pur = sales[index];

        return SaleItem(
          context,
          totalHeight,
          totalWidth,
          pur,
        );
      });
}
