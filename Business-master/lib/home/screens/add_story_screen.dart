import 'dart:io';

import 'package:business/helper/constanc.dart';
import 'package:business/home/viewmodel/add_story_viewmodel.dart';
import 'package:business/widget/button/custom_button.dart';
import 'package:business/widget/custom_appbar.dart';
import 'package:business/widget/custom_text_form_field.dart';
import 'package:business/widget/loading_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class AddStoryScreen extends ConsumerWidget {
  const AddStoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final viewModel = watch(addStoryViewModel);
    return Scaffold(
        appBar: customAppBar(title: 'اضافة حالة') as PreferredSizeWidget?,
        body: LoadingStack(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                viewModel.profileImage != null
                    ? Container(
                        width: Get.width,
                        height: Get.height / 3,
                        child: Image.file(
                          File(viewModel.profileImage!.path),
                          fit: BoxFit.fill,
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          await viewModel.getImageFromGallery();
                        },
                        child: Container(
                          width: Get.width,
                          child: Image.asset(
                            'assets/images/add_image.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  hint: 'اضف الحالة',
                  validator: (value) {},
                  maxLines: 5,
                  controller: viewModel.storyBodyController,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  height: 50,
                  text: 'اضافة ',
                  onPressed: () {
                    viewModel.addStory();
                  },
                  color: primaryColor,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
          isLoading: viewModel.isLoading,
        ));
  }
}
