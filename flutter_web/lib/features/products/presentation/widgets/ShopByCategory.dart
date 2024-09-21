import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/features/language/lang.dart';
import 'package:flutter_web/features/products/presentation/bloc/category/category_bloc.dart';
import 'package:flutter_web/features/products/presentation/bloc/category/category_events.dart';
import 'package:flutter_web/features/products/presentation/bloc/category/category_state.dart';
import 'package:flutter_web/features/products/presentation/pages/products_list_screen.dart';

class ShopByCategory extends StatefulWidget {
  const ShopByCategory({super.key});

  @override
  State<ShopByCategory> createState() => _ShopByCategoryState();
}

class _ShopByCategoryState extends State<ShopByCategory> {
  ScrollController scrollController = ScrollController();

  double index = 0;

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(FetchCategories());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
      if (state is CategoriesLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is CategoriesLoaded) {
        return Column(
          children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: MediaQuery.of(context).size.width >
                        state.categories.length * 300
                    ? Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 20),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('shop_by_category'),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 25),
                            ),
                          ),
                        ],
                      )
                    : Row(children: [
                        Container(
                          margin: const EdgeInsets.only(right: 20),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('shop_by_category'),
                            style: TextStyle(color: Colors.black, fontSize: 25),
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
                                  double divided = index / 300;
                                  double smallerThanDividedByOne =
                                      divided + 1 - (divided.toInt());

                                  index =
                                      index - (smallerThanDividedByOne * 300);
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
                              color:
                                  index > ((state.categories.length - 3) * 300)
                                      ? Colors.grey
                                      : Colors.black,
                              icon:
                                  const Icon(Icons.arrow_forward_ios_outlined),
                              onPressed: () {
                                //  print(state.categories.length * 500);
                                setState(() {
                                  if (MediaQuery.of(context).size.width >
                                      state.categories.length * 300) {
                                    // print("back");
                                    return;
                                  }
                                  if (index >
                                      ((state.categories.length - 3) * 300)) {
                                    return;
                                  }
                                  //  index = index + 300;

                                  double divided = index / 300;
                                  double biggeThanDividedByOne =
                                      (divided.toInt() + 1) - divided;

                                  index = index + (biggeThanDividedByOne * 300);
                                  //print(index);
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
                      itemCount: state.categories.length,
                      itemBuilder: ((context, index) {
                        final cat = state.categories[index];
                        return GestureDetector(
                          child: CategoryCard(
                            category: cat,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductListScreenSL(Category: cat),
                              ),
                            );
                          },
                        );
                      })),
                ))
          ],
        );
      } else if (state is CategoryError) {
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

class CategoryCard extends StatelessWidget {
  final String category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    print(AppLocalizations.of(context).translate(category));
    return SizedBox(
      height: 300,
      width: 300,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context).translate(category),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
