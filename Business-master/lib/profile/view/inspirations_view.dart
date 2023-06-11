import 'package:business/profile/view/add_new_inspired.dart';
import 'package:business/profile/viewModel/inspiration_viewmodel.dart';
import 'package:business/widget/button/custom_button.dart';
import 'package:business/widget/custom_appbar.dart';
import 'package:business/widget/custom_text.dart';
import 'package:business/widget/custom_text_form_field_withour_border.dart';
import 'package:business/widget/loading_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InspirationsView extends ConsumerWidget {
  const InspirationsView({
    Key? key,
    required this.myProfile,
  }) : super(key: key);

  final bool myProfile;

  @override
  Widget build(BuildContext context, watch) {
    final viewModel = watch(inspirationViewModel);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:customAppBarWithLeading(title: 'الملهمين') as PreferredSizeWidget?,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(// Mina 10/1/2022
                      onPressed: () async {
                        Get.to(AddInspired());
                      },
                      padding: EdgeInsets.only(top: 20),
                      alignment: Alignment.bottomCenter,
                      icon: Icon(
                        Icons.upload_sharp,
                        color: Colors.grey,
                        size: 50,
                      ),
                    ),

                Expanded(
                  child: CustomTextFormFieldWithoutBorder(
                    hint: 'بحث عن ملهمين',
                    onSave: (String? s) {},
                    validator: (String? valid) {},
                    icons: Icons.search,
                  ),
                ),
              ],
            ),
          ),
/*
          Padding(
            padding: const EdgeInsets.all(20),
            child: CustomTextFormFieldWithoutBorder(
              hint: 'بحث عن ملهمين',
              onSave: (String? s) {},
              validator: (String? valid) {},
              icons: Icons.search,
            ),
          ),
*/
          Expanded(
            child: LoadingStack(
              isLoading: viewModel.isLoading,
              child: viewModel.inspirationModel!.isEmpty
                  ? Center(child: CustomText(text: 'لا يوجود ملهمين'))
                  : ListView.separated(
                      itemCount: viewModel.inspirationModel!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Card(
                            child: ListTile(
                              leading: Container(
                                width: 150.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    /*         Container(
                                      height: 35.h,
                                      width: 80.w,
                                      child: CustomButton(
                                        onPressed: () {
                                          print(viewModel
                                                  .inspirationModel![index]
                                                  .inspirerendeId! +
                                              " if -===");
                                          Get.to(() => ProfileScreen(
                                                userId: int.parse(viewModel
                                                    .inspirationModel![index]
                                                    .userId!),//Mina Changer from inspirerendeId 7/1/2022
                                              ));
                                        },
                                        text: 'الملف الشخصي',
                                        fontSize: 8,
                                      ),
                                    ),*/
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Container(
                                      height: 35.h,
                                      width: 100.w,
                                      child: CustomButton(
                                        onPressed: () {
                                          viewModel.removeInspiration(
                                              id: viewModel
                                                  .inspirationModel![index]
                                                  .inspirerendeId!);
                                        },
                                        text: 'حذف',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              title: CustomText(
                                text: viewModel
                                    .inspirationModel![index].user!.name,
                                alignment: Alignment.center,
                              ),
                              trailing: CircleAvatar(
                                radius: 30.0,
                                backgroundImage: NetworkImage(viewModel
                                    .inspirationModel![index]
                                    .user!
                                    .personalImage!),
                                backgroundColor: Colors.transparent,
                              ),
                              onTap: () {},
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                        height: 20,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
