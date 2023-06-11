import 'package:business/authintication/forget/view/forget_password_view.dart';
import 'package:business/authintication/login/viewmodel/login_viewmodel.dart';
import 'package:business/authintication/register/view/create_account_view.dart';
import 'package:business/core/viewmodel/top_level_viewmodel.dart';
import 'package:business/helper/constanc.dart';
import 'package:business/view/control_view/control_view.dart';
import 'package:business/widget/button/custom_button.dart';
import 'package:business/widget/custom_border_button.dart';
import 'package:business/widget/custom_text.dart';
import 'package:business/widget/custom_text_form_field.dart';
import 'package:business/widget/loading_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              CustomText(
                alignment: Alignment.center,
                fontSize: 24,
                color: darkColor,
                text: 'تسجيل دخول',
              ),
              SizedBox(
                height: 20,
              ),
              CustomText(
                alignment: Alignment.center,
                color: darkColor,
                fontSize: 20,
                text: 'مرحبا برجوعك',
              ),
              SizedBox(
                height: 20,
              ),
              Consumer(
                builder: (BuildContext context,
                    T Function<T>(ProviderBase<Object, T>) watch,
                    Widget? child) {
                  final viewModel = watch(loginViewModel);
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: viewModel.emailController,
                          icons: Icons.email_outlined,
                          hint: 'البريد الألكتروني',
                          validator: (String? value) {
                            Pattern pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regex = new RegExp(pattern as String);
                            if (!regex.hasMatch(value!))
                              return 'برجاء التاكد من صحة البريد الألكتروني';
                            else
                              return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          controller: viewModel.passwordController,
                          isPassword: true,
                          icons: Icons.lock_open_outlined,
                          hint: 'كلمة السر',
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'كلمة السر مطلوبة';
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => ForgetPasswordView());
                },
                child: CustomText(
                  alignment: Alignment.bottomRight,
                  color: greyColor,
                  text: 'نسيت كلمة السر؟',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Consumer(
                builder: (BuildContext context,
                    T Function<T>(ProviderBase<Object, T>) watch,
                    Widget? child) {
                  final viewModel = watch(loginViewModel);
                  return LoadingStack(
                    isLoading: watch(isLoadingProvider).state,
                    child: CustomButton(
                      onPressed: () {
                        watch(isLoadingProvider).state = true;
                        if (_formKey.currentState!.validate()) {
                          viewModel.userLogin().then((value) {
                            if (value) {
                              Get.offAll(ControlView());
                            }
                            watch(isLoadingProvider).state = false;
                          });
                        }
                      },
                      text: 'تسجيل دخول',
                      height: 60,
                      textColor: Colors.white,
                    ),
                  );
                },
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
                    text: '   لا تمتلك حساب ؟   ',
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
                  Get.to(() => CreateAccountView());
                },
                text: 'مستخدم جديد',
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
