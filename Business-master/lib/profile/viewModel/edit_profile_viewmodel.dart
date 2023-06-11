import 'dart:async';
import 'dart:io';

import 'package:business/authintication/register/model/country_city_model.dart';
import 'package:business/authintication/register/repo/country_repo.dart';
import 'package:business/core/network/local/cache_helper.dart';
import 'package:business/helper/constanc.dart';
import 'package:business/helper/functions.dart';
import 'package:business/profile/model/edit_profile_model.dart';
import 'package:business/profile/model/profile_model.dart';
import 'package:business/profile/repo/edit_profile_repo.dart';
import 'package:dio/dio.dart' as dios;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

final editProfileViewModel = ChangeNotifierProvider.family.autoDispose(
  (ref, ProfileModel profileModel) => EditProfileViewModel(profileModel),
);

class EditProfileViewModel extends ChangeNotifier {
  EditProfileViewModel(this.profileModel) {
    myToken = CacheHelper.getStringData(key: "myToken");
    nameController = TextEditingController(text: profileModel.name);
    emailController = TextEditingController(text: profileModel.email);
    phoneController = TextEditingController(text: profileModel.phone);
    jobTitleController =
        TextEditingController(text: profileModel.jobTitle ?? "");
    specialtyController =
        TextEditingController(text: profileModel.specialty ?? '');
    businessTypeController = TextEditingController(
      text: profileModel.businessType ?? '',
    );
    birthDay = profileModel.birthDate!;
    genderDropDown = profileModel.gender!;
    getCountry();
  }

  String? myToken;
  late ProfileModel profileModel;
  bool isLoadingUploadImage = false;

  File? profileImage, coverImage;
  String? coverImageFileName;
  String? profileImageFileName;

  /// Dummy
  late TextEditingController nameController,
      emailController,
      phoneController,
      jobTitleController,
      specialtyController,
      businessTypeController;
  String birthDay = '';
  String? genderDropDown = 'النوع';

  List<CountryCityModel>? countriesList = [];
  List<CountryCityModel>? cityList = [];
  CountryCityModel? selectedCountryModel;
  CountryCityModel? selectedCityModel;
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

  setBirthday(String birth) {
    birthDay = birth;
    print(birthDay);
    notifyListeners();
  }

  void changeGender(String? value) {
    genderDropDown = value;
    notifyListeners();
  }

  Future getImageFromGallery(String type) async {
    final ImagePicker _picker = ImagePicker();
    final pickedFIle = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFIle != null) {
      if (type == "profile") {
        profileImage = File(pickedFIle.path);
        profileImageFileName = profileImage!.path.split('/').last;
        if (profileImage != null) await uploadImage("profile");
      } else {
        coverImage = File(pickedFIle.path);
        coverImageFileName = coverImage!.path.split('/').last;
        if (coverImage != null) await uploadImage("cover");
      }
      notifyListeners();
    } else {
      showToast(msg: 'No Image selected');
      print("No Image selected");
    }
  }

  Future uploadImage(String type) async {
    isLoadingUploadImage = true;
    notifyListeners();
    try {
      var result = await EditProfileRepo.uploadImage(
        token: myToken!,
        type: type,
        image: type == "profile"
            ? await dios.MultipartFile.fromFile(
                profileImage!.path,
                filename: profileImageFileName,
              )
            : await dios.MultipartFile.fromFile(
                coverImage!.path,
                filename: coverImageFileName,
              ),
      );
      if (result is bool && result == true) {
        isLoadingUploadImage = false;
        notifyListeners();
        if (type == "profile") {
          Get.back(result: true);
        } else {
          return true;
        }
      } else {
        isLoadingUploadImage = false;
        notifyListeners();
        showToast(msg: 'حدث مشكلة');
      }
    } catch (e) {
      isLoadingUploadImage = false;
      notifyListeners();
      showToast(msg: 'حدث مشكلة');
      print(e);
    }
  }

  Future editUserProfile() async {
    try {
      await EditProfileRepo.updateAccount(
        EditProfileModel(
          name: nameController.text,
          username: nameController.text,
          email: emailController.text,
          phone: phoneController.text,
          jobTitle: jobTitleController.text,
          birthDate: birthDay,
          countryId: selectedCountryModel!.id.toString(),
          cityId: selectedCityModel!.id.toString(),
          gender: genderDropDown,
          token: myToken,
          businessType: businessTypeController.text,
          specialty: specialtyController.text,
        ),
        myToken!,
      );
      Get.back();
    } catch (e) {
      showToast(msg: e.toString(), color: colorBgToastError);
      print(e.toString());
    }
  }
}
