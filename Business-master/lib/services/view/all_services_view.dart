import 'package:business/services/models/category_model.dart';
import 'package:business/services/view/search_service_view.dart';
import 'package:business/services/view/services_view.dart';
import 'package:business/services/viewModel/all_services_viewModel.dart';
import 'package:business/widget/button/custom_button_with_border.dart';
import 'package:business/widget/custom_appbar.dart';
import 'package:business/widget/custom_text.dart';
import 'package:business/widget/loading_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AllServiceView extends ConsumerWidget {
  AllServiceView(this.categoriesModelList, this.selectedCategory);

  final List<CategoriesModel>? categoriesModelList;
  final CategoriesModel selectedCategory;

  @override
  Widget build(BuildContext context, watch) {
    final viewModel = watch(servicesViewModel(selectedCategory.id.toString()));
    return Scaffold(
      appBar: customAppBarWithLeading(title: 'الخدمات') as PreferredSizeWidget?,
      body: Container(
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
                  top: 20
                ),
                child: Container(
                  padding: const EdgeInsets.all(15),//Mina from 20 5/1/2022
                  decoration: BoxDecoration(
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomText(
                        text: 'بتدور على ايه ؟',
                        alignment: Alignment.center,
                        color: Colors.grey,
                      ),
                      Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 60,
              // color: Colors.teal,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: categoriesModelList!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButtonWithBorder(
                      text: categoriesModelList![index].name,
                      textColor: Colors.black,
                      onPress: () async {
                        await viewModel.getServiceProducts(
                          categoryId: categoriesModelList![index].id.toString(),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: LoadingStack(
                isLoading: viewModel.isLoading,
                child: viewModel.servicesDataList!.length > 0
                    ? Container(
                        child: GridView.count(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 2,//Mina It was 3 now made it 2
                          childAspectRatio: .950,// Changed the ratio from 650
                          children: List.generate(
                              viewModel.servicesDataList!.length, (index) {
                            return InkWell(
                              onTap: () {
                                Get.to(
                                  () => ServicesView(
                                    viewModel.servicesDataList![index],
                                  ),
                                );
                              },
                              child: Card(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 120.h,
                                      child: FadeInImage.assetNetwork(
                                        fadeInDuration: Duration(seconds: 1),
                                        fit: BoxFit.cover,
                                        placeholder:
                                            "assets/images/waiting.png",
                                        image: viewModel
                                                    .servicesDataList![index]
                                                    .media!
                                                    .length >
                                                0
                                            ? viewModel.servicesDataList![index]
                                                .media![0]
                                            : "https://th.bing.com/th/id/OIP.hTQHlnEVJc6lMKqO49vcfAAAAA?pid=ImgDet&rs=1",
                                      ),
                                    ),
                                    Text(
                                      viewModel
                                              .servicesDataList![index].title ??
                                          '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Align(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          viewModel.servicesDataList![index]
                                                  .price ??
                                              0.0.toString(),
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                      alignment: Alignment.bottomRight,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      )
                    : CustomText(
                        text: "No Services Added",
                        alignment: Alignment.center,
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
