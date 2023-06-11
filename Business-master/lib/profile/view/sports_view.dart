import 'package:business/helper/constanc.dart';
import 'package:business/profile/components/all_sprots_item_component.dart';
import 'package:business/profile/components/my_sprots_item_component.dart';
import 'package:business/profile/viewModel/sports_viewmodel.dart';
import 'package:business/widget/button/custom_button.dart';
import 'package:business/widget/custom_appbar.dart';
import 'package:business/widget/custom_text.dart';
import 'package:business/widget/custom_text_form_field_withour_border.dart';
import 'package:business/widget/loading_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SportsView extends ConsumerWidget {
  const SportsView({
    Key? key,
    required this.myProfile,
  }) : super(key: key);

  final bool myProfile;

  @override
  Widget build(BuildContext context, watch) {
    //final viewModel = watch(sportsViewModel);
    return Scaffold(
      appBar: customAppBarWithLeading(title: 'الرياضات') as PreferredSizeWidget?,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: CustomTextFormFieldWithoutBorder(
              hint: 'بحث عن رياضتك المفضله',
              onSave: (String? s) {},
              validator: (String? valid) {},
              icons: Icons.search,
            ),
          ),
          Consumer(
            builder: (BuildContext context,
                T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
              final viewModel = watch(sportsViewModel);
              return Expanded(
                child: LoadingStack(
                  isLoading: viewModel.isLoading,
                  child: viewModel.allSportsModelList!.length == 0
                      ? Padding(
                          padding: const EdgeInsets.all(100),
                          child: Center(
                            child: CustomText(
                              alignment: Alignment.center,
                              text: "لا يوجود رياضات الان",
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CustomButton(
                                      height: 60,
                                      onPressed: () {
                                        viewModel.chooseButton(1);
                                      },
                                      text: 'رياضاتي',
                                      color: viewModel.buttonSelected == 1
                                          ? primaryColor
                                          : Colors.white,
                                      textColor: viewModel.buttonSelected == 1
                                          ? Colors.white
                                          : primaryColor,
                                    ),
                                  ),
                                  Expanded(
                                    child: CustomButton(
                                      height: 60,
                                      onPressed: () {
                                        viewModel.chooseButton(0);
                                      },
                                      text: ' كل الرياضات',
                                      color: viewModel.buttonSelected == 1
                                          ? Colors.white
                                          : primaryColor,
                                      textColor: viewModel.buttonSelected == 1
                                          ? primaryColor
                                          : Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Expanded(
                              child: viewModel.buttonSelected == 0
                                  ? GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: Get.width / 2,
                                        childAspectRatio:
                                            MediaQuery.of(context).size.width /
                                                (MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    2),
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 20,
                                      ),
                                      itemCount:
                                          viewModel.allSportsModelList!.length,
                                      itemBuilder: (BuildContext ctx, index) {
                                        return AllSportsItemComponent(
                                          onPressAll: () {
                                            print("he");
                                            viewModel.addSports(
                                                sportsModel: viewModel
                                                        .allSportsModelList![
                                                    index]);
                                          },
                                          sportsMode: viewModel
                                              .allSportsModelList![index],
                                        );
                                      })
                                  : viewModel.mySportsModelList!.isEmpty
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomText(
                                              alignment: Alignment.center,
                                              text: "لا يوجد رياضات مضافة",
                                            ),
                                          ],
                                        )
                                      : GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: Get.width / 2,
                                            childAspectRatio:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    (MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        2),
                                            crossAxisSpacing: 20,
                                            mainAxisSpacing: 20,
                                          ),
                                          itemCount: viewModel
                                              .mySportsModelList!.length,
                                          itemBuilder:
                                              (BuildContext ctx, index) {
                                            return MySportsItemComponent(
                                              onPressDelete: () {
                                                viewModel.removeSports(
                                                    sportsModel: viewModel
                                                        .mySportsModelList![
                                                            index]
                                                );
                                              },
                                              sportsModel: viewModel
                                                  .mySportsModelList![index],
                                            );
                                          },
                                        ),
                            ),
                          ],
                        ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
