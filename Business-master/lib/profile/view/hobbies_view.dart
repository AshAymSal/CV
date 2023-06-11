import 'package:business/helper/constanc.dart';
import 'package:business/profile/components/all_hobbies_item_component.dart';
import 'package:business/profile/components/my_hobbies_item_component.dart';
import 'package:business/profile/viewModel/hobbies_viewmodel.dart';
import 'package:business/widget/button/custom_button.dart';
import 'package:business/widget/custom_appbar.dart';
import 'package:business/widget/custom_text.dart';
import 'package:business/widget/custom_text_form_field_withour_border.dart';
import 'package:business/widget/loading_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HobbiesView extends ConsumerWidget {
  const HobbiesView({
    Key? key,
    required this.myProfile,
  }) : super(key: key);

  final bool myProfile;

  @override
  Widget build(BuildContext context, watch) {
    return Scaffold(
      appBar:
          customAppBarWithLeading(title: 'الهوايات') as PreferredSizeWidget?,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: CustomTextFormFieldWithoutBorder(
              hint: 'بحث عن الهوايات المفضله',
              onSave: (String? s) {},
              validator: (String? valid) {},
              icons: Icons.search,
            ),
          ),
          Consumer(
            builder: (BuildContext context,
                T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
              final viewModel = watch(hobbiesViewModel);
              return Expanded(
                child: LoadingStack(
                  isLoading: viewModel.isLoading,
                  child: viewModel.allHobbiesModelList!.length == 0
                      ? Padding(
                          padding: const EdgeInsets.all(100),
                          child: Center(
                            child: CustomText(
                              alignment: Alignment.center,
                              text: "لا يوجود هوايات الان",
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
                                      text: 'هواياتي',
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
                                      text: ' كل الهوايات',
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
                                          viewModel.allHobbiesModelList!.length,
                                      itemBuilder: (BuildContext ctx, index) {
                                        return AllHobbiesItemComponent(
                                          onPressAll: () {
                                            viewModel.addHobbies(
                                                hobbiesModel: viewModel
                                                        .allHobbiesModelList![
                                                    index]);
                                          },
                                          hobbiesMode: viewModel
                                              .allHobbiesModelList![index],
                                        );
                                      })
                                  : viewModel.myHobbiesModelList!.isEmpty
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
                                              .myHobbiesModelList!.length,
                                          itemBuilder:
                                              (BuildContext ctx, index) {
                                            return MyHobbiesItemComponent(
                                              onPressDelete: () {
                                                viewModel.removeHobbies(
                                                  model: viewModel
                                                          .myHobbiesModelList![
                                                      index],
                                                );
                                              },
                                              sportsModel: viewModel
                                                  .myHobbiesModelList![index],
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
