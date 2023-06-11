import 'package:business/authintication/register/model/country_city_model.dart';
import 'package:business/authintication/register/repo/country_repo.dart';
import 'package:business/core/network/local/cache_helper.dart';
import 'package:business/helper/constanc.dart';
import 'package:business/helper/functions.dart';
import 'package:business/services/models/category_model.dart';
import 'package:business/services/repos/add_services_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

final addServicesViewModel =
    ChangeNotifierProvider.autoDispose((ref) => AddServicesViewModel());

class AddServicesViewModel extends ChangeNotifier {
  AddServicesViewModel() {
    myToken = CacheHelper.getStringData(key: "myToken");
    getCountry();
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  String? myToken;
  bool isLoading = false;
  List<XFile> imageFiles = [];
  final ImagePicker _picker = ImagePicker();

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

  pickedFilesImages() async {
    try {
      final pickedFileList = await (_picker.pickMultiImage());
      imageFiles..addAll(pickedFileList!);
      print(imageFiles);
      notifyListeners();
    } catch (e) {
      print(e.toString());
      notifyListeners();
    }
  }

  deleteSelectedImage(XFile index) {
    imageFiles.remove(index);
    notifyListeners();
  }

  Future addServices({required CategoriesModel selectedCategoryModel}) async {
    isLoading = true;
    notifyListeners();

    List<MultipartFile> list = [];
    for (int i = 0; i < imageFiles.length; i++) {
      list.add(
        await MultipartFile.fromFile(
          imageFiles[0].path,
          filename: basename(imageFiles[0].path),
        ),
      );
    }
    try {
      await AddServicesRepo.addServices(
        token: myToken,
        title: titleController.text,
        body: bodyController.text,
        price: priceController.text,
        categoryId: selectedCategoryModel.id!,
        files: list,
        countryId: selectedCountryModel!.id!,
        cityId: selectedCityModel!.id!,
      );
    } catch (e) {
      showToast(msg: e.toString(), color: colorBgToastError);
      print(e.toString());
    }
    isLoading = false;
    notifyListeners();
  }
}
