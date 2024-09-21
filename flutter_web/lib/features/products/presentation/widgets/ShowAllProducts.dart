import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/features/language/lang.dart';
import 'package:flutter_web/features/products/presentation/bloc/product/product_bloc.dart';
import 'package:flutter_web/features/products/presentation/bloc/product/product_event.dart';
import 'package:flutter_web/features/products/presentation/bloc/product/product_state.dart';

class ShowAllProducts extends StatefulWidget {
  const ShowAllProducts({super.key});

  @override
  State<ShowAllProducts> createState() => _ShowAllProductsState();
}

class _ShowAllProductsState extends State<ShowAllProducts> {
  late ScrollController scrollController;

  double index = 0;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

    context.read<ProductBloc>().add(FetchProducts());
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      if (state is ProductLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is ProductLoaded) {
        return NotificationListener<ScrollNotification>(
            onNotification: (n) {
              //   print(scrollController.position.pixels);
              setState(() {
                index = scrollController.position.pixels;
              });

              return false;
            },
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    //  color: Colors.grey,
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Row(children: [
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('shop_all_products'),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 25),
                        ),
                      ),
                      const Spacer(),
                      Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          alignment: Alignment.center,
                          height: 40,
                          width: 40,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: index == 0 ? Colors.grey : Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                if (index < 1) return;
                                double divided = index / 390;
                                double smallerThanDividedByOne =
                                    divided - (divided.toInt());

                                if (smallerThanDividedByOne == 0) {
                                  smallerThanDividedByOne = 1;
                                }

                                index = index - (smallerThanDividedByOne * 390);
                              });
                              scrollController.animateTo(index,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            },
                          )),
                      const SizedBox(width: 20),
                      Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_forward_ios_outlined),
                            color: index > ((state.products.length - 3) * 390)
                                ? Colors.grey
                                : Colors.black,
                            onPressed: () {
                              // print(state.products.length * 500);
                              setState(() {
                                if (index >
                                    ((state.products.length - 3) * 390)) {
                                  return;
                                }
                                double divided = index / 390;
                                double biggeThanDividedByOne =
                                    (divided.toInt() + 1) - divided;

                                index = index + (biggeThanDividedByOne * 390);
                                // print(index);
                              });
                              scrollController.animateTo(index,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            },
                          )),
                    ])),
                SizedBox(
                    height: 350,
                    width: MediaQuery.of(context).size.width,
                    child: Scrollbar(
                      controller: scrollController,
                      trackVisibility: true,
                      thumbVisibility: true,
                      thickness: 20,
                      radius: const Radius.elliptical(7, 7),
                      child: ListView.builder(
                          controller: scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: state.products.length,
                          itemBuilder: ((context, index) {
                            final product = state.products[index];
                            return GestureDetector(
                              child:
                                  _productWidget(product.title, product.image),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/detalis',
                                  arguments: product,
                                );
                              },
                            );
                          })),
                    ))
              ],
            ));
      } else if (state is ProductError) {
        return Center(child: Text(state.message));
      } else {
        return Center(
            child: Text(
          AppLocalizations.of(context).translate('no_products_founded'),
        ));
      }
    });
  }
}

Widget _productWidget(String title, String image) {
  return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      // height: 70,
      width: 350,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 270,
            width: 460,
            child: Image.network(
              image,
              fit: BoxFit.fitHeight,
            ),
          ),
          Text(title),
        ],
      ));
}
