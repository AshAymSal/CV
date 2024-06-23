import 'package:ecommernce/core/widgets/loading_widget.dart';
import 'package:ecommernce/features/products/presentation/bloc/category/category_bloc.dart';
import 'package:ecommernce/features/products/presentation/bloc/category/category_state.dart';
import 'package:ecommernce/features/products/presentation/widgets/message_display_widget.dart';
import 'package:ecommernce/features/products/presentation/widgets/one_product_big_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget catigoryby(String s, BuildContext context) {
  return BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
    if (state is LoadingProductsByCategoryState) {
      return LoadingWidget();
    } else if (state is LoadedProductsByCategoryState) {
      return productsByCategoryList(products: state.productsByCategory);
    } else if (state is ErrorProductsByCategoryState) {
      return MessageDisplayWidget(message: state.message);
    }
    return LoadingWidget();
  });
}

Widget productsByCategoryList({required List products}) {
  return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final pro = products[index];
        return slOneProduct(pro);
      });
}
