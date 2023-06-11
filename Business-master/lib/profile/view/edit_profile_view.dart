import 'package:business/authintication/register/model/country_city_model.dart';
import 'package:business/core/viewmodel/top_level_viewmodel.dart';
import 'package:business/helper/constanc.dart';
import 'package:business/helper/functions.dart';
import 'package:business/profile/model/profile_model.dart';
import 'package:business/profile/viewModel/edit_profile_viewmodel.dart';
import 'package:business/widget/button/custom_button.dart';
import 'package:business/widget/custom_appbar.dart';
import 'package:business/widget/custom_text.dart';
import 'package:business/widget/custom_text_form_field.dart';
import 'package:business/widget/loading_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditProfileView extends ConsumerWidget {
  EditProfileView({
    required this.profileModel,
  });

  final ProfileModel profileModel;

  @override
  Widget build(BuildContext context, watch) {
    final viewModel = watch(editProfileViewModel(profileModel));
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBarWithLeading(title: 'حسابى') as PreferredSizeWidget?,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    height: 180.h,
                    child: Stack(children: <Widget>[
                      Positioned(
                        right: 0,
                        top: 10.h,
                        child: Row(
                          children: [
                            LoadingStack(
                              isLoading: viewModel.isLoadingUploadImage,
                              child: Container(
                                width: 120.0.w,
                                height: 120.0.h,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 8.0,
                                        offset: Offset(0.0, 5.0),
                                      ),
                                    ],
                                    image: viewModel.profileImage != null
                                        ? DecorationImage(
                                            fit: BoxFit.fill,
                                            image: FileImage(
                                                viewModel.profileImage!),
                                          )
                                        : DecorationImage(
                                            fit: BoxFit.contain,
                                            image: NetworkImage(
                                                profileModel.personalImage!),
                                          )),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomText(
                                  fontSize: 24.sp,
                                  text: profileModel.name,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.grey,
                                    ),
                                    CustomText(
                                      alignment: Alignment.topLeft,
                                      text: profileModel.country ?? '',
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: -5.w,
                        top: 90.h,
                        child: !viewModel.isLoadingUploadImage
                            ? InkWell(
                                onTap: () {
                                  viewModel.getImageFromGallery("profile");
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.transparent,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 8.0,
                                            offset: Offset(0.0, 5.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox.shrink(),
                      )
                    ]),
                  ),
                  Container(
                    width: Get.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * .03,
                        ),
                        CustomTextFormField(
                          hint: profileModel.name ?? '',
                          validator: (value) {},
                          icons: Icons.person,
                          controller: viewModel.nameController,
                        ),
                        SizedBox(
                          height: Get.height * .03,
                        ),
                        CustomTextFormField(
                          hint: 'ahmedmamdoh1@gmail.com',
                          validator: (value) {},
                          icons: Icons.email,
                          controller: viewModel.emailController,
                        ),
                        SizedBox(
                          height: Get.height * .03,
                        ),
                        CustomTextFormField(
                          hint: profileModel.phone ?? '',
                          validator: (value) {},
                          icons: Icons.phone,
                          controller: viewModel.phoneController,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          hint: profileModel.jobTitle ?? '',
                          validator: (value) {},
                          icons: Icons.work,
                          controller: viewModel.jobTitleController,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomTextFormField(
                          hint: profileModel.businessType ?? 'اسم الشركة',
                          validator: (value) {},
                          icons: Icons.work,
                          controller: viewModel.businessTypeController,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          hint: profileModel.specialty ?? 'المؤهل العلمي',
                          validator: (value) {},
                          icons: Icons.work,
                          controller: viewModel.specialtyController,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                theme: DatePickerTheme(
                                  headerColor: primaryColor,
                                  backgroundColor: Colors.white,
                                  itemStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  doneStyle: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ), onConfirm: (date) {
                              viewModel.setBirthday(
                                  '${date.year}-${date.month}-${date.day}');
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.ar);
                          },
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.only(right: 10.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey,
                                )),
                            width: Get.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.date_range_outlined,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: Text(
                                    viewModel.birthDay == ''
                                        ? 'تاريخ الميلاد'
                                        : viewModel.birthDay,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
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
                                items: <String>[
                                  'النوع',
                                  'ذكر',
                                  'انثي'
                                ].map<DropdownMenuItem<String>>((String value) {
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
                                hint: Text(
                                    viewModel.selectedCountryModel?.name! ??
                                        ' '),
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
                        CustomButton(
                          height: 50,
                          text: 'حفظ التعديلات',
                          onPressed: () async {
                            _formKey.currentState!.save();
                            if (_formKey.currentState!.validate()) {
                              if (viewModel.birthDay.length > 5) {
                                if (viewModel.genderDropDown != 'النوع') {
                                  watch(isLoadingProvider).state = true;
                                  await viewModel.editUserProfile();

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
                          color: Colors.grey[100],
                          textColor: Colors.grey,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          height: 50,
                          text: 'تسجيل خروج',
                          onPressed: () {},
                          color: Colors.red,
                          textColor: Colors.white,
                        ),
                      ],
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
