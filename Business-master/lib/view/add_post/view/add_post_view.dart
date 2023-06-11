import 'dart:io';

import 'package:business/helper/constanc.dart';
import 'package:business/view/add_post/viewmodel/add_post_viewmodel.dart';
import 'package:business/view/control_view/viewmodel/control_view_model.dart';
import 'package:business/widget/button/custom_button.dart';
import 'package:business/widget/custom_text.dart';
import 'package:business/widget/custom_text_form_field_without_icon.dart';
import 'package:business/widget/loading_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddPostView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final viewModel = watch(addPostViewModel);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          titleSpacing: 0.0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: CustomText(
              text: 'اضافة',
              alignment: Alignment.center,
              fontSize: 24,
              color: primaryColor,
            ),
          ),
          actions: [IconButton(
            color: Colors.black,
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_forward_ios_sharp),
          )],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 40,
            ),
            child: Column(
              children: [
                CustomTextFormFieldWithoutIcon(
                  hint: 'شرح الموضوع',
                  validator: (value) {},
                  controller: viewModel.titleController,
                ),
                SizedBox(
                  height: 40.h,
                ),
                GetImageWidget(),
                SizedBox(
                  height: 40,
                ),
                LoadingStack(
                  isLoading: viewModel.isLoading,
                  child: CustomButton(
                    onPressed: () async {
                      await viewModel.addPost();
                      context.read(controlViewModel).changedItem(0);
                      Get.back();
                    },
                    text: 'نشر',
                    color: Colors.grey.shade200,
                    height: 50,
                    textColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GetImageWidget extends ConsumerWidget {
  const GetImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final viewModel = watch(addPostViewModel);
    return viewModel.imageFiles.length > 0
        ? Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceEvenly,
                children: viewModel.imageFiles
                    .map(
                      (item) => Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            width: Get.width / 2,
                            height: Get.height / 3,
                            child: Image.file(
                              File(item.path),
                              fit: BoxFit.fill,
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 5,
                            child: GestureDetector(
                              onTap: () {
                                viewModel.deleteSelectedImage(item);
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Icon(
                                  Icons.clear,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList()
                    .cast<Widget>(),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  await viewModel.pickedFilesImages();
                },
                child: Container(
                  width: Get.width - 40,
                  child: Image.asset(
                    'assets/images/add_image.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          )
        : GestureDetector(
            onTap: () async {
              await viewModel.pickedFilesImages();
            },
            child: Container(
              width: Get.width,
              child: Image.asset(
                'assets/images/add_image.png',
                fit: BoxFit.cover,
              ),
            ),
          );
  }
}
