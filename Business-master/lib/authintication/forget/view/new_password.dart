import 'package:business/authintication/forget/viewmodel/forget_password_viewmodel.dart';
import 'package:business/helper/functions.dart';
import 'package:business/widget/button/custom_button.dart';
import 'package:business/widget/custom_text_form_field.dart';
import 'package:business/widget/loading_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewPassword extends StatefulWidget {
  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  var _passwordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Center(
            child: ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                Form(
                  key: formKey,
                  child: Consumer(
                    builder: (BuildContext context,
                        T Function<T>(ProviderBase<Object, T>) watch,
                        Widget? child) {
                      final viewModel = watch(forgetPasswordViewModel);
                      return Column(
                        children: [
                          CustomTextFormField(
                            isPassword: true,
                            controller: viewModel.passwordController,
                            icons: Icons.lock_open_outlined,
                            hint: 'كلمة السر',
                            validator: (value) {
                              if (value.length < 6) {
                                return 'كلمة المرور يجب ان تكون اكبر من ٦ ارقم';
                              }
                              if (value !=
                                  viewModel.confirmPasswordController.text) {
                                return 'كلمة المرور غير متطابقة';
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                            isPassword: true,
                            controller: viewModel.confirmPasswordController,
                            icons: Icons.lock_open_outlined,
                            hint: 'تاكيد كلمة السر',
                            validator: (String? value) {
                              if (value!.length < 6) {
                                return 'كلمة المرور يجب ان تكون اكبر من ٦ ارقم';
                              }
                              if (value != viewModel.passwordController.text) {
                                return 'كلمة المرور غير متطابقة';
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          LoadingStack(
                            isLoading: viewModel.isLoading,
                            child: CustomButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  String pass = _passwordController.text;
                                  String confirmPass =
                                      _confirmPasswordController.text;
                                  if (pass == confirmPass) {
                                    viewModel.resetPasswordCode();
                                  } else {
                                    showToast(
                                        msg: 'الباسودات يجب ان تكون متشابهه');
                                  }
                                }
                              },
                              text: 'حفظ',
                              textColor: Colors.white,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
