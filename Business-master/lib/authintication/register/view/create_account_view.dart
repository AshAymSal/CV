import 'package:business/authintication/login/login_view.dart';
import 'package:business/authintication/register/viewmodel/create_account_view_model.dart';
import 'package:business/helper/constanc.dart';
import 'package:business/helper/functions.dart';
import 'package:business/widget/button/custom_button.dart';
import 'package:business/widget/custom_border_button.dart';
import 'package:business/widget/custom_text.dart';
import 'package:business/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'complete_data_view.dart';

///
class CreateAccountView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final _viewModel = watch(createAccountViewModel);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 150,
                      width: 150,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomText(
                      alignment: Alignment.center,
                      fontSize: 24,
                      color: darkColor,
                      text: 'مستخدم جديد',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomText(
                      alignment: Alignment.center,
                      color: darkColor,
                      fontSize: 20,
                      text: 'مرحبا بك',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      controller: _viewModel.nameController,
                      icons: Icons.person_outline_outlined,
                      hint: 'اسم المستخدم',
                      validator: (value) {
                        if (value.length == 0) {
                          return 'اسم المستخدم مطلوب';
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      controller: _viewModel.emailController,
                      icons: Icons.email_outlined,
                      hint: 'البريد الألكتروني',
                      validator: (value) {
                        if (value.length == 0) {
                          return 'البريد الألكتروني مطلوب';
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      controller: _viewModel.phoneController,
                      icons: Icons.phone,
                      hint: 'رقم الهاتف',
                      validator: (String? value) {
                        if (value!.length == 0) {
                          return 'رقم الهاتف مطلوب';
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      controller: _viewModel.passwordController,
                      icons: Icons.lock_open_outlined,
                      hint: 'كلمة السر',
                      isPassword: true,
                      validator: (value) {
                        if (value.length < 6) {
                          return 'كلمة المرور يجب ان تكون اكبر من ٦ ارقم';
                        }
                        if (value !=
                            _viewModel.confirmPasswordController.text) {
                          return 'كلمة المرور غير متطابقة';
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      controller: _viewModel.confirmPasswordController,
                      icons: Icons.lock_open_outlined,
                      hint: 'تاكيد كلمة السر',
                      isPassword: true,
                      validator: (String? value) {
                        if (value!.length < 6) {
                          return 'كلمة المرور يجب ان تكون اكبر من ٦ ارقم';
                        }
                        if (value != _viewModel.passwordController.text) {
                          return 'كلمة المرور غير متطابقة';
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CustomText(
                              alignment: Alignment.topRight,
                              color: greyColor,
                              fontSize: 12,
                              text:
                                  'باستخدام هذا التطبيق فأنت توافق على الالتزام بهذه الشروط والأحكام',
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Consumer(
                            builder: (BuildContext context,
                                T Function<T>(ProviderBase<Object, T>) watch,
                                Widget? child) {
                              final viewModel = watch(createAccountViewModel);
                              return Checkbox(
                                activeColor: primaryColor,
                                value: viewModel.termsSelected,
                                onChanged: (value) {
                                  viewModel.changeTerms();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      onPressed: () {
                        _formKey.currentState!.save();
                        if (_formKey.currentState!.validate()) {
                          if (_viewModel.termsSelected != true) {
                            customSnackBar(
                              message1: 'يجب الموافقة علي الشروط والاحكام',
                              message2: '',
                            );
                          } else {
                            Get.to(() => CompleteDataView());
                          }
                        }
                      },
                      text: 'تسجيل',
                      height: 60,
                      textColor: Colors.white,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: greyColor,
                            thickness: 1.5,
                          ),
                        ),
                        CustomText(
                          alignment: Alignment.center,
                          color: greyColor,
                          text: '   تمتلك حساب ؟   ',
                        ),
                        Expanded(
                          child: Divider(
                            color: greyColor,
                            thickness: 1.5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CustomBorderButton(
                      onPressed: () {
                        Get.offAll(() => LoginView());
                      },
                      text: 'تسجيل دخول',
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
