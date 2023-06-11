import 'package:business/helper/constanc.dart';
import 'package:business/services/view/all_services_view.dart';
import 'package:business/services/view/search_service_view.dart';
import 'package:business/services/viewModel/get_category_viewmodel.dart';
import 'package:business/widget/custom_appbar.dart';
import 'package:business/widget/custom_text.dart';
import 'package:business/widget/loading_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';


class AllCategoryScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final categoryViewModel = watch(getCategoryViewModel);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.back();
        },
        child: Icon(Icons.add),
        backgroundColor: primaryColor,
      ),
      appBar: customAppBar(title: 'الخدمات') as PreferredSizeWidget?,
      body: SafeArea(
        child: LoadingStack(
          isLoading: categoryViewModel.isLoading,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => SearchServiceView());
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.fromBorderSide(
                        BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row( // Mina Changed the order 5/1/2022
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        CustomText(
                          text: 'بتدور على ايه ؟',
                          alignment: Alignment.center,
                          color: Colors.grey,
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: categoryViewModel.categoriesModelList!.length == 0
                    ? CustomText(
                        text: 'لا يوجد خدمات',
                      )
                    : Container(
                        child: GridView.count(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 2,//Mina was 3 now 2 5/1/2022
                          children: List.generate(
                              categoryViewModel.categoriesModelList!.length,
                              (index) {
                            return InkWell(
                              onTap: () {
                                Get.to(
                                  () => AllServiceView(
                                    categoryViewModel.categoriesModelList,
                                    categoryViewModel
                                        .categoriesModelList![index],
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Card(
                                        elevation: 5,
                                        child: FadeInImage.assetNetwork(
                                          width: double.infinity / 2,//Mina was 3 now 2 5/1/2022
                                          fadeInDuration: Duration(seconds: 1),
                                          placeholder:
                                              "assets/images/waiting.png",
                                          image: categoryViewModel
                                              .categoriesModelList![index]
                                              .image!,
                                          fit: BoxFit.cover,
                                          // fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    categoryViewModel
                                        .categoriesModelList![index].name!,
                                  ),
                                  SizedBox( // Mina added Sized box 5/1/2022
                                    height: 10,
                                  )
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
