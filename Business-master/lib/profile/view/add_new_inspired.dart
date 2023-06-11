import 'package:business/helper/constanc.dart';
import 'package:business/widget/button/custom_button.dart';
import 'package:business/widget/custom_text.dart';
import 'package:business/widget/custom_text_form_field_without_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class AddInspired extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    //final viewModel = watch(addMusicViewModel);
// Mina 10/1/2022
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
              padding: const EdgeInsets.only(top: 25),
              child: CustomText(
                text: 'اضافة ملهم',
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
            padding: const EdgeInsets.all(
           20
            ),
            child: Form(
            //  key: viewModel.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: [
                      CustomTextFormFieldWithoutIcon(
                        hint: 'اسم ملهم',
                        validator: (String? value) {},
                    //    controller: viewModel.nameController,
                      ),
                      SizedBox(
                        height: 40,
                      ),
            /*          InkWell(
                        onTap: () {
                      //    viewModel.getImageFromGallery();
                        },
                        child: viewModel.musicCoverImage != null
                            ? Image.file(
                          viewModel.musicCoverImage!,
                          width: 100,
                          height: 100,
                        )*/
                            Container(
                          width: Get.width,
                          child: Image.asset(
                            'assets/images/add_image.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ]),
                      SizedBox(
                        height: 40,
                      ),
                         CustomButton(
                          onPressed: () async {
                          },
                          text: 'نشر',
                          color: Colors.grey.shade200,
                          height: 50,
                          textColor: Colors.black,
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
