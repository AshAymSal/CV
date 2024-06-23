import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/products/presentation/widgets/one_product_big_widget.dart';
import 'package:flutter/material.dart';

Widget ProuctsBySearch({required List<Product> productsBySearch}) {
  return ListView.builder(
      itemCount: productsBySearch.length,
      itemBuilder: (context, index) {
        final pro = productsBySearch[index];
        return slOneProduct(pro);
      });
}
