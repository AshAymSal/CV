import 'dart:io';

import 'package:business/authintication/register/model/country_city_model.dart';
import 'package:business/helper/functions.dart';
import 'package:business/services/models/category_model.dart';
import 'package:business/services/viewModel/add_services_viewmodel.dart';
import 'package:business/services/viewModel/get_category_viewmodel.dart';
import 'package:business/widget/button/custom_button.dart';
import 'package:business/widget/custom_text_form_field_without_icon.dart';
import 'package:business/widget/loading_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddServicesScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final viewModel = watch(addServicesViewModel);
    final viewModelCategoryViewModel = watch(getCategoryViewModel);

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar:AppBar(
          elevation: 0.0,
          titleSpacing: 0.0,
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            color: Colors.black,
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios_sharp),
          )
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),

                  CustomTextFormFieldWithoutIcon(
                    hint: 'العنوان',
                    validator: (String? value) {
                      if (value!.length == 0) {
                        showToast(msg: 'يجب اضافة عنوان الخدمة');
                        return 'يجب اضافة عنوان الخدمة';
                      }
                    },
                    controller: viewModel.titleController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextFormFieldWithoutIcon(
                    hint: 'شرح الموضوع',
                    validator: (value) {
                      if (value!.length == 0) {
                        showToast(msg: 'يجب اضافة شرح الخدمة');
                        return 'يجب اضافة شرح الخدمة';
                      }
                    },
                    controller: viewModel.bodyController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextFormFieldWithoutIcon(
                    hint: 'السعر ',
                    validator: (String? value) {
                      if (value!.length == 0) {
                        showToast(msg: 'يجب اضافة سعر الخدمة');
                        return 'يجب اضافة سعر الخدمة';
                      }
                    },
                    controller: viewModel.priceController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  LoadingStack(
                    isLoading: viewModelCategoryViewModel.isLoading,
                    child: Container(
                      padding: EdgeInsets.only(right: 12),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey,
                          )),
                      width: Get.width,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(right: 12.w, left: 20.w),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: DropdownButton<CategoriesModel>(
                            isExpanded: true,
                            hint: Text("اختر الفئة "),
                            value: viewModelCategoryViewModel
                                .selectedCategoryModel,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.black),
                            underline: Container(
                              color: Colors.transparent,
                            ),
                            onChanged:
                                viewModelCategoryViewModel.changeCategory,
                            items: viewModelCategoryViewModel
                                .categoriesModelList!
                                .map<DropdownMenuItem<CategoriesModel>>(
                                    (CategoriesModel value) {
                              return DropdownMenuItem<CategoriesModel>(
                                value: value,
                                child: Text(
                                  value.name!,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 12),
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                        )),
                    width: Get.width,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(right: 12.w, left: 20.w),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: DropdownButton<CountryCityModel>(
                          isExpanded: true,
                          hint: Text(
                              viewModel.selectedCountryModel?.name! ?? ' '),
                          value: viewModel.selectedCountryModel,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.black),
                          underline: Container(
                            color: Colors.transparent,
                          ),
                          onChanged: viewModel.changeCountry,
                          items: viewModel.countriesList!
                              .map<DropdownMenuItem<CountryCityModel>>(
                                  (CountryCityModel value) {
                            return DropdownMenuItem<CountryCityModel>(
                                value: value,
                                child: Text(
                                  value.name!,
                                ));
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 12),
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                        )),
                    width: Get.width,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(right: 12.w, left: 20.w),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: DropdownButton<CountryCityModel>(
                          isExpanded: true,
                          hint: Text("اختر المدينة "),
                          value: viewModel.selectedCityModel,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.black),
                          underline: Container(
                            color: Colors.transparent,
                          ),
                          onChanged: viewModel.changeCity,
                          items: viewModel.cityList!
                              .map<DropdownMenuItem<CountryCityModel>>(
                                  (CountryCityModel value) {
                            return DropdownMenuItem<CountryCityModel>(
                                value: value,
                                child: Text(
                                  value.name!,
                                ));
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GetImageWidget(),
                  SizedBox(
                    height: 30.h,
                  ),
                  LoadingStack(
                    isLoading: viewModel.isLoading,
                    child: CustomButton(
                      onPressed: () async {
                        formKey.currentState!.save();
                        if (formKey.currentState!.validate()) {
                          await viewModel.addServices(
                            selectedCategoryModel: viewModelCategoryViewModel
                                .selectedCategoryModel!,
                          );
                          Get.back();
                        }
                      },
                      text: 'نشر',
                      color: Colors.grey.shade200,
                      height: 50.h,
                      width: 200.w,
                      textColor: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 100.h,
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

class GetImageWidget extends ConsumerWidget {
  const GetImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final viewModel = watch(addServicesViewModel);
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
