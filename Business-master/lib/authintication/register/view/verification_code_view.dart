import 'package:business/authintication/forget/viewmodel/forget_password_viewmodel.dart';
import 'package:business/authintication/register/viewmodel/create_account_view_model.dart';
import 'package:business/core/viewmodel/top_level_viewmodel.dart';
import 'package:business/helper/constanc.dart';
import 'package:business/helper/functions.dart';
import 'package:business/helper/spaces.dart';
import 'package:business/view/control_view/control_view.dart';
import 'package:business/widget/button/custom_button.dart';
import 'package:business/widget/custom_text.dart';
import 'package:business/widget/loading_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationCodeView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                clipper: CustomHalfCircleClipper(),
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(
                        MediaQuery.of(context).size.width / 2,
                      ),
                      bottomLeft: Radius.circular(
                        MediaQuery.of(context).size.width / 2,
                      ),
                    ),
                  ),
                  child: Container(
                    padding: paddingA20,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(300),
                        bottomLeft: Radius.circular(300),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: marginA10,
                            child: IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            width: 30,
                            height: 35,
                          ),
                        ),
                        CustomText(
                          alignment: Alignment.center,
                          fontSize: 24,
                          color: Colors.white,
                          text: 'كود التحقق',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomText(
                          color: Colors.white,
                          alignment: Alignment.center,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          text: 'ارسلنا لك كود التحقق على الأيميل',
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Consumer(
                          builder: (BuildContext context,
                              T Function<T>(ProviderBase<Object, T>) watch,
                              Widget? child) {
                            final viewModel = watch(createAccountViewModel);

                            return CustomText(
                              alignment: Alignment.center,
                              color: darkColor,
                              fontSize: 14,
                              text: '',
                              // '${viewModel.userModel.data.client.email} ارسل الي',
                            );
                          },
                        ),
                        SizedBox(
                          height: 45,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Consumer(
                builder: (BuildContext context,
                    T Function<T>(ProviderBase<Object, T>) watch,
                    Widget? child) {
                  final viewModel = watch(createAccountViewModel);
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 70),
                    child: PinCodeTextField(
                      autoDisposeControllers: false,
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        inactiveFillColor: Colors.white,
                        inactiveColor: Colors.white,
                        shape: PinCodeFieldShape.box,
                        activeColor: Colors.black38,
                        selectedColor: Colors.black38,
                        selectedFillColor: primaryColor,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                      ),
                      cursorColor: Colors.black,
                      animationDuration: Duration(milliseconds: 300),
                      backgroundColor: Colors.white,
                      enableActiveFill: true,
                      controller: viewModel.otpController,
                      keyboardType: TextInputType.number,
                      boxShadows: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {},
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                      onChanged: (String value) {},
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Consumer(
                  builder: (BuildContext context,
                      T Function<T>(ProviderBase<Object, T>) watch,
                      Widget? child) {
                    final viewModel = watch(createAccountViewModel);
                    return LoadingStack(
                      isLoading: watch(isLoadingProvider).state,
                      child: CustomButton(
                        height: 50,
                        onPressed: () {
                          watch(isLoadingProvider).state = true;
                          if (viewModel.otpController.text ==
                              viewModel.createAccountModel!.verificationCode) {
                            viewModel.verificationAccount().then((value) {
                              if (value) {
                                showToast(msg: 'تم التاكيد بنجاح');
                                Get.offAll(ControlView());
                              } else {
                                showToast(msg: 'الكود خاطئ');
                              }
                            });
                          } else {
                            showToast(msg: 'الكود خاطئ');
                          }
                          watch(isLoadingProvider).state = false;
                        }, //116750
                        text: 'تاكيد',
                        textColor: Colors.white,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomText(
                alignment: Alignment.center,
                text: 'لم تتلق كود ؟',
                fontWeight: FontWeight.w300,
              ),
              SizedBox(
                height: 20,
              ),
              Consumer(
                builder: (BuildContext context,
                    T Function<T>(ProviderBase<Object, T>) watch,
                    Widget? child) {
                  return GestureDetector(
                    onTap: () {
                      watch(forgetPasswordViewModel).forgetPass();
                    },
                    child: CustomText(
                      alignment: Alignment.center,
                      color: primaryColor,
                      text: 'اعادة الارسال',
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomHalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = new Path();
    // top line
    path.lineTo(0, size.width);
    // right line
    path.lineTo(size.width, size.width);
    // bottom
    path.lineTo(size.width, 0);
    // left line
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
