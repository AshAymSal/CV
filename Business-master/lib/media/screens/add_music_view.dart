import 'package:business/helper/constanc.dart';
import 'package:business/helper/functions.dart';
import 'package:business/media/viewmodel/add_music_viewmodel.dart';
import 'package:business/widget/button/custom_button.dart';
import 'package:business/widget/button/custom_button_with_border.dart';
import 'package:business/widget/custom_text.dart';
import 'package:business/widget/custom_text_form_field_without_icon.dart';
import 'package:business/widget/loading_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class AddMusicView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final viewModel = watch(addMusicViewModel);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:  AppBar(
          elevation: 0.0,
          titleSpacing: 0.0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: CustomText(
              text: 'اضافة موسيقي',
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
              top: 20,
            ),
            child: Form(
              key: viewModel.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: [
                      CustomTextFormFieldWithoutIcon(
                        hint: 'اسم الموسيقي',
                        validator: (String? value) {},
                        controller: viewModel.nameController,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () {
                          viewModel.getImageFromGallery();
                        },
                        child: viewModel.musicCoverImage != null
                            ? Image.file(
                                viewModel.musicCoverImage!,
                                width: 100,
                                height: 100,
                              )
                            : Container(
                                width: Get.width,
                                child: Image.asset(
                                  'assets/images/add_image.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      CustomButtonWithBorder(
                        width: Get.width / 1.3,
                        onPress: () {
                          viewModel.getMusicFile();
                        },
                        text: "ارفق ملف الموسيقي",
                        textColor: Colors.grey,
                        borderColor: Colors.grey,
                      ),
                      if (viewModel.musicFile != null)
                        Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            CustomText(
                              text: viewModel.musicFile!.path,
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 40,
                      ),
                      LoadingStack(
                        isLoading: viewModel.isLoading!,
                        child: CustomButton(
                          onPressed: () async {
                            viewModel.formKey.currentState!.save();
                            if (viewModel.nameController.text.length != 0)
                              await viewModel.addMusic();
                            else
                              showToast(msg: 'الأسم مطلوب');
                          },
                          text: 'نشر',
                          color: Colors.grey.shade200,
                          height: 50,
                          textColor: Colors.black,
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
