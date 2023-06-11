import 'dart:async';

import 'package:business/authintication/register/model/country_city_model.dart';
import 'package:business/authintication/register/model/create_account_model.dart';
import 'package:business/authintication/register/repo/country_repo.dart';
import 'package:business/authintication/register/repo/register_repo.dart';
import 'package:business/authintication/register/view/verification_code_view.dart';
import 'package:business/core/network/local/shared_preferences_service.dart';
import 'package:business/helper/constanc.dart';
import 'package:business/helper/functions.dart';
import 'package:business/profile/model/profile_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

final createAccountViewModel =
    ChangeNotifierProvider.autoDispose<RegisterViewModel>((ref) {
  return RegisterViewModel(
    sharedPreferencesService: ref.watch(sharedPreferencesServiceProvider),
  );
});

class RegisterViewModel with ChangeNotifier {
  RegisterViewModel({required this.sharedPreferencesService}) {
    getCountry();
  }

  bool termsSelected = false;
  var dio = Dio();

  /// Dummy
  TextEditingController nameController =
      TextEditingController(text: 'usama elgendy');
  TextEditingController emailController =
      TextEditingController(text: 'usamaaelgendy@gmail.com');
  TextEditingController phoneController =
      TextEditingController(text: '01061636637');
  TextEditingController passwordController =
      TextEditingController(text: '123456789');
  TextEditingController confirmPasswordController =
      TextEditingController(text: '123456789');
  TextEditingController jobTitleController =
      TextEditingController(text: 'Software engineer');

  /// Real
  // TextEditingController nameController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController phoneController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  // TextEditingController confirmPasswordController = TextEditingController();
  // TextEditingController jobTitleController = TextEditingController();
  String birthDay = '';
  String? genderDropDown = 'النوع';
  SharedPreferencesService sharedPreferencesService;

  /// OPT
  TextEditingController otpController = TextEditingController();

  CreateAccountModel? createAccountModel;

  CountryCityModel? selectedCountryModel;
  CountryCityModel? selectedCityModel;
  List<CountryCityModel>? countriesList = [];
  List<CountryCityModel>? cityList = [];
  bool isLoadingCountry = false;
  bool isLoadingCity = false;

  void getCountry() async {
    isLoadingCountry = true;
    notifyListeners();
    countriesList = await CountryRepo.getCountry();
    selectedCountryModel = countriesList![0];
    getCity(countryId: countriesList![0].id!);
    notifyListeners();
  }

  void getCity({required int countryId}) async {
    isLoadingCountry = true;
    notifyListeners();
    cityList = await CountryRepo.getCities(countryId: countryId);
    isLoadingCountry = false;
    notifyListeners();
  }

  void changeCountry(CountryCityModel? value) {
    selectedCountryModel = value;
    getCity(countryId: selectedCountryModel!.id!);
    notifyListeners();
  }

  void changeCity(CountryCityModel? value) {
    selectedCityModel = value;
    notifyListeners();
  }

  changeTerms() {
    termsSelected = !termsSelected;
    notifyListeners();
  }

  setBirthday(String birth) {
    birthDay = birth;
    notifyListeners();
  }

  void changeGender(String? value) {
    genderDropDown = value;
    notifyListeners();
  }

  Future registerWithEmailAndPassword() async {
    try {
      await RegisterRepo.registerUserAccount(CreateAccountModel(
        name: nameController.text,
        username: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
        jobTitle: jobTitleController.text,
        birthDate: birthDay,
        countryId: selectedCountryModel!.id ?? 0,
        cityId: selectedCityModel!.id ?? 0,
        gender: genderDropDown,
      )).then((user) {
        if (user != null) {
          createAccountModel = user;
          print(user.toMap());
          Get.offAll(() => VerificationCodeView());
        }
      });
    } catch (e) {
      showToast(msg: e.toString(), color: colorBgToastError);
      print(e.toString());
    }
  }

  Future<bool> verificationAccount() async {
    notifyListeners();
    try {
      ProfileModel? userModelRequest =
          await RegisterRepo.verificationUserAccount(
        code: otpController.text,
        email: emailController.text,
        password: passwordController.text,
      );
      if (userModelRequest != null) {
        sharedPreferencesService.setUserData(userModelRequest);

        notifyListeners();
        return true;
      } else {
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e.toString());
      notifyListeners();
      return false;
    }
  }
}
