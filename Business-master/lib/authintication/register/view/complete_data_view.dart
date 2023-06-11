import 'package:business/authintication/register/model/country_city_model.dart';
import 'package:business/authintication/register/viewmodel/create_account_view_model.dart';
import 'package:business/authintication/register/widget/birthday_widget.dart';
import 'package:business/core/viewmodel/top_level_viewmodel.dart';
import 'package:business/helper/constanc.dart';
import 'package:business/helper/functions.dart';
import 'package:business/widget/button/custom_button.dart';
import 'package:business/widget/custom_text.dart';
import 'package:business/widget/custom_text_form_field.dart';
import 'package:business/widget/loading_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CompleteDataView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final viewModel = watch(createAccountViewModel);
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                ),
                child: Column(
                  children: [
                    CustomText(
                      alignment: Alignment.center,
                      fontSize: 24,
                      color: darkColor,
                      text: 'برجاء اكمال البيانات الخاصه بك',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      icons: Icons.work_outline_outlined,
                      hint: 'الوظيفة',
                      validator: (value) {
                        if (value.length == 0) {
                          return 'الوظيفة مطلوبة';
                        }
                      },
                      controller: viewModel.jobTitleController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    BirthDayWidget(),
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
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: viewModel.genderDropDown,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            style: TextStyle(color: Colors.grey),
                            underline: Container(
                              height: 0,
                              color: Colors.transparent,
                            ),
                            onChanged: viewModel.changeGender,
                            items: <String>['النوع', 'ذكر', 'انثي']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    fontSize: 24,
                                  ),
                                ),
                              );
                            }).toList(),
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
                            hint: Text(viewModel.selectedCountryModel!.name!),
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
                    LoadingStack(
                      isLoading: watch(isLoadingProvider).state,
                      child: CustomButton(
                        onPressed: () async {
                          _formKey.currentState!.save();
                          if (_formKey.currentState!.validate()) {
                            if (viewModel.birthDay.length > 5) {
                              if (viewModel.genderDropDown != 'النوع') {
                                watch(isLoadingProvider).state = true;
                                await viewModel.registerWithEmailAndPassword();

                                watch(isLoadingProvider).state = false;
                              } else {
                                customSnackBar(
                                  message2: '',
                                  message1: 'يجب اختيار النوع',
                                );
                              }
                            } else {
                              customSnackBar(
                                message2: '',
                                message1: 'يجب اختيار تاريخ الميلاد',
                              );
                            }
                          }
                        },
                        text: 'تسجيل',
                        height: 60,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
