import 'package:business/helper/constanc.dart';
import 'package:business/services/models/all_services_model.dart';
import 'package:business/services/viewModel/services_details_controller.dart';
import 'package:business/widget/button/custom_button.dart';
import 'package:business/widget/custom_text.dart';
import 'package:business/widget/loading_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ServicesView extends ConsumerWidget {
  final ServicesModel productDetails;

  ServicesView(this.productDetails);

  @override
  Widget build(BuildContext context, watch) {
    final viewModel = watch(servicesDetailsViewModel(productDetails));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: LoadingStack(
        isLoading: viewModel.isLoading,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Center(
                    child: FadeInImage.assetNetwork(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 3,
                      fadeInDuration: Duration(seconds: 1),
                      placeholder: "assets/images/waiting.png",
                      image: viewModel.model.media!.length > 0
                          ? viewModel.model.media![0]
                          : "https://th.bing.com/th/id/OIP.hTQHlnEVJc6lMKqO49vcfAAAAA?pid=ImgDet&rs=1",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(viewModel.model.title ?? ''),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      viewModel.model.price ?? "",
                      style: TextStyle(color: primaryColor, fontSize: 24),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CustomText(
                      text: "وصف المنتج",
                      alignment: Alignment.centerRight,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(viewModel.model.body!),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CustomText(
                      text: "المعلن",
                      alignment: Alignment.centerRight,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ListTile(
                    leading: viewModel.model.publisherData!.id ==
                            viewModel.sharedPreferencesService.getUserData()!.id
                        ? SizedBox.shrink()
                        : viewModel.model.isFollow
                            ? CustomButton(
                                text: "الغاء المتابعة",
                                width: 150.w,
                                onPressed: () async {
                                  await viewModel.unFollowPublisher();
                                },
                              )
                            : CustomButton(
                                text: "متابعه",
                                width: 100,
                                onPressed: () async {
                                  await viewModel.followPublisher();
                                },
                              ),
                    title: Center(
                        child: Text(viewModel.model.publisherData?.name ?? '')),
                    trailing: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: FadeInImage.assetNetwork(
                        fadeInDuration: Duration(seconds: 1),
                        placeholder: "assets/images/waiting.png",
                        image: viewModel.model.publisherData!.personalImage!,
                      ),
                    ),
                  ),
                  viewModel.model.publisherData!.id ==
                          viewModel.sharedPreferencesService.getUserData()!.id
                      ? SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: CustomButton(
                            text: "تواصل مع المعلن",
                            onPressed: () {
                              viewModel.navigationToChatMessageScreen(
                                  viewModel.model);
                            },
                          ),
                        ),
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 55,
                          child: CustomButton(
                            text: "حذف",
                            onPressed: () {},
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Container(
                          height: 55,
                          child: CustomButton(
                            text: "تعديل",
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
