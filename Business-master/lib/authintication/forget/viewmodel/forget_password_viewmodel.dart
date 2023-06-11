import 'dart:async';
import 'dart:convert';

import 'package:business/authintication/forget/repo/forget_password_repo.dart';
import 'package:business/authintication/forget/view/code_forget_view.dart';
import 'package:business/authintication/login/login_view.dart';
import 'package:business/core/network/end_points.dart';
import 'package:business/core/network/remote/api_request.dart';
import 'package:business/helper/constanc.dart';
import 'package:business/helper/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

final forgetPasswordViewModel =
    ChangeNotifierProvider((ref) => ForgetPasswordViewModel());

class ForgetPasswordViewModel extends ChangeNotifier {
  bool isLoading = false;

  /// Forget password view
  String? codeFromRequestMsg;

  /// Dummy
  // TextEditingController emailController =
  //     TextEditingController(text: 'uu@gmail.com');

  /// Real
  TextEditingController emailController = TextEditingController();

  /// OPT
  TextEditingController otpController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  /// New password
  TextEditingController passwordController =
      TextEditingController(text: '123456789');
  TextEditingController confirmPasswordController =
      TextEditingController(text: '123456789');

  ForgetPasswordViewModel() {
    errorController = StreamController<ErrorAnimationType>();
  }

  void forgetPass() {
    isLoading = true;
    notifyListeners();
    ApiRequest.postData(
        url: FORGET_PASSWORD,
        body: {"email": emailController.text}).then((value) {
      print(value.data);
      if (value.data.toString().contains("true")) {
        codeFromRequestMsg = value.data["msg"];
        print(codeFromRequestMsg);
        Get.to(() => CodeForgetView());
        showToast(
          msg: "تم ارسال الكود الى البريد الالكترونى",
        );
      } else {
        // String msg = json.decode(value.data)["msg"].toString();
        showToast(msg: "البريد الالكترونى غير صحيح", color: colorBgToastError);
      }
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      showToast(msg: onError.toString(), color: colorBgToastError);
      isLoading = false;
      notifyListeners();
    });
  }

  void resetPasswordCode() {
    isLoading = true;
    notifyListeners();
    ForgetPasswordRepo.resetPasswordCode(
            email: emailController.text,
            password: passwordController.text,
            confirmPassword: confirmPasswordController.text)
        .then((value) {
      if (value.data.toString().contains("verification_code")) {
        ///TODO
        // CacheHelper.putBoolData(key: "isLogin", value: true)
        //     .then((value) {
        //   Get.offAll(Home());
        // });
        Get.offAll(LoginView());
        showToast(
          msg: "تم تغيير الباسورد بنجاح",
        );
      } else {
        String msg = json.decode(value.data)["msg"].toString();
        showToast(msg: msg, color: colorBgToastError);
      }
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      showToast(msg: onError.toString(), color: colorBgToastError);
      isLoading = false;
      notifyListeners();
    });
  }

  // @override
  // void dispose() {
  //   errorController.close();
  //   super.dispose();
  // }
}
