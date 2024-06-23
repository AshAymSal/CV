import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/products/presentation/widgets/home_page/one_product_small_widget.dart';
import 'package:flutter/material.dart';

/*Widget mostPupularList(BuildContext context) {
  return Container(
      height: 150,
      child: FutureBuilder<List>(
        future: homeProvider.getRead(context).getPopular(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              List mostPopular = homeProvider.getRead(context).mostPopular;

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: mostPopular.length,
                itemBuilder: (BuildContext context, int index) {
                  Product pro = mostPopular[index];
                  return slOneProductWidgetHomePage(pro);
                },
              );
          }
        },
      ));
}
*/
Widget mostPupularList({required context, required List<Product> Populars}) {
  return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Populars.length,
        itemBuilder: (BuildContext context, int index) {
          Product pro = Populars[index];
          return slOneProductWidgetHomePage(pro);
        },
      ));
}
