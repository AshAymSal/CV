import 'package:business/authintication/forget/viewmodel/forget_password_viewmodel.dart';
import 'package:business/helper/constanc.dart';
import 'package:business/widget/button/custom_button.dart';
import 'package:business/widget/custom_text.dart';
import 'package:business/widget/custom_text_form_field.dart';
import 'package:business/widget/loading_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgetPasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 200,
              width: 200,
            ),
            CustomText(
              alignment: Alignment.center,
              fontSize: 24,
              color: darkColor,
              text: 'نسيت كلمة السر',
            ),
            SizedBox(
              height: 20,
            ),
            CustomText(
              alignment: Alignment.center,
              color: darkColor,
              fontSize: 20,
              text: 'ادخل البريد الالكترونى المرتبط بحسابك',
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            Consumer(
              builder: (BuildContext context,
                  T Function<T>(ProviderBase<Object, T>) watch, Widget? child) {
                return CustomTextFormField(
                  icons: Icons.email_outlined,
                  hint: 'البريد الألكتروني',
                  validator: (value) {},
                  controller: watch(forgetPasswordViewModel).emailController,
                );
              },
            ),
            SizedBox(
              height: 80,
            ),
            Consumer(
              builder: (BuildContext context,
                  T Function<T>(ProviderBase<Object, T>) watch, Widget? child) {
                return LoadingStack(
                  isLoading: watch(forgetPasswordViewModel).isLoading,
                  child: CustomButton(
                    onPressed: () {
                      watch(forgetPasswordViewModel).forgetPass();
                    },
                    text: 'ارسال',
                    height: 60,
                    textColor: Colors.white,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
