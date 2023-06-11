import 'package:business/services/view/services_view.dart';
import 'package:business/services/viewModel/search_services_viewmodel.dart';
import 'package:business/widget/custom_appbar.dart';
import 'package:business/widget/custom_text_form_field_withour_border.dart';
import 'package:business/widget/loading_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class SearchServiceView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final viewModel = watch(searchServicesViewModel);
    return Scaffold(
      appBar: customAppBar(title: 'الخدمات') as PreferredSizeWidget?,
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: CustomTextFormFieldWithoutBorder(
                hint: 'بتدور على ايه ؟',
                onSave: (String? s) {},
                validator: (String? valid) {},
                icons: Icons.search,
                onChange: (String? value) {
                  if (value!.length > 3) {
                    viewModel.getSearchServiceProducts(searchText: value);
                  }
                },
              ),
            ),
            Expanded(
              child: LoadingStack(
                isLoading: viewModel.isLoading,
                child: viewModel.searchServicesModel!.length > 0
                    ? Container(
                        child: GridView.count(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          childAspectRatio: .650,
                          children: List.generate(
                              viewModel.searchServicesModel!.length, (index) {
                            return InkWell(
                              onTap: () {
                                Get.to(
                                  () => ServicesView(
                                    viewModel.searchServicesModel![index],
                                  ),
                                );
                              },
                              child: Card(
                                child: Column(
                                  children: [
                                    FadeInImage.assetNetwork(
                                      fadeInDuration: Duration(seconds: 1),
                                      placeholder: "assets/images/waiting.png",
                                      image: viewModel
                                                  .searchServicesModel![index]
                                                  .media!
                                                  .length >
                                              0
                                          ? viewModel
                                              .searchServicesModel![index]
                                              .media![0]
                                          : "https://th.bing.com/th/id/OIP.hTQHlnEVJc6lMKqO49vcfAAAAA?pid=ImgDet&rs=1",
                                    ),
                                    Text(
                                      viewModel
                                          .searchServicesModel![index].title ?? '',
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
                                          viewModel.searchServicesModel![index]
                                                  .price ??
                                              "0.0",
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
                    : Center(
                        child: Image.asset(
                          'assets/images/search.png',
                          height: Get.height * 0.4,
                          width: Get.width,
                        ),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
