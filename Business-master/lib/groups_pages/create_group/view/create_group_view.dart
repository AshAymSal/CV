import 'package:business/groups_pages/create_group/viewmodel/create_groupe_viewmodel.dart';
import 'package:business/widget/button/custom_button.dart';
import 'package:business/widget/custom_appbar.dart';
import 'package:business/widget/custom_text.dart';
import 'package:business/widget/custom_text_form_field_without_icon.dart';
import 'package:business/widget/dropDown/custom_dropdown_menu_widget.dart';
import 'package:business/widget/loading_stack.dart';
import 'package:business/widget/upload_image/custom_upload_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateGroupView extends ConsumerWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final bool isPage;

  CreateGroupView({
    required this.isPage,
  });

  @override
  Widget build(BuildContext context, watch) {
    final viewModel = watch(createGroupViewModel(isPage));
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBarWithLeading(
          title: isPage ? 'انشاء صفحة جديدة' : 'انشاء مجموعة جديدة',
        ) as PreferredSizeWidget?,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormFieldWithoutIcon(
                    hint: isPage ? 'اسم الصفحة' : 'اسم المجموعة',
                    validator: (value) {},
                    controller: viewModel.nameController,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomText(
                    alignment: Alignment.centerRight,
                    text: 'الخصوصية',
                    fontSize: 16,
                  ),
                  CustomDropdownMenuWidget(
                    value: watch(privacyChangeDropdownValueProvider).state,
                    list: <String>['عام', 'خاص'],
                    onChange: (String? value) {
                      watch(privacyChangeDropdownValueProvider).state = value!;
                    },
                  ),
                  CustomText(
                    alignment: Alignment.centerRight,
                    text: 'الفئة',
                    fontSize: 16,
                  ),
                  CustomDropdownMenuWidget(
                    value: watch(categoryChangeDropdownValueProvider).state,
                    list: <String>['اجتماعي', 'رياضي', 'اخبار', 'ترفيه'],
                    onChange: (String? value) {
                      watch(categoryChangeDropdownValueProvider).state = value!;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomUploadImageWidget(
                    text: 'اضافة صوره',
                    press: () {
                      viewModel.getImageFromGallery('profile');
                    },
                    imageFile: viewModel.profileImage,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomUploadImageWidget(
                    text: 'اضافة صوره الغلاف',
                    press: () {
                      viewModel.getImageFromGallery('cover');
                    },
                    imageFile: viewModel.coverImage,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormFieldWithoutIcon(
                    hint: isPage ? 'وصف الصفحة ' : 'وصف المجموعة',
                    validator: (value) {
                      if (value.length == 0) {
                        return 'يجب كتابة وصف المجموعة';
                      }
                    },
                    controller: viewModel.descriptionController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextFormFieldWithoutIcon(
                      controller: viewModel.rulesController,
                      hint: isPage ? 'قواعد الصفحة' : 'قواعد المجموعة',
                      validator: (String? value) {
                        if (value!.length == 0) {
                          return 'يجب تحديد قواعد المجموعة';
                        }
                      }),
                  SizedBox(
                    height: 30,
                  ),
                  LoadingStack(
                    isLoading: viewModel.isLoading,
                    child: CustomButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await viewModel.createGroup(
                            watch(privacyChangeDropdownValueProvider).state,
                          );
                        }
                      },
                      text: 'إنشاء',
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
      ),
    );
  }
}
