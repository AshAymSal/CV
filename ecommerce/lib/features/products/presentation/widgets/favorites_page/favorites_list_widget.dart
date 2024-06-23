import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/products/presentation/widgets/one_product_big_widget.dart';
import 'package:flutter/material.dart';

Widget favoriteListWidget({
  BuildContext? context,
  List<Product>? favorites,
}) {
  return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: favorites!.length,
      itemBuilder: (context, index) {
        final pro = favorites[index];
        return slOneProduct(pro);
      });
}
