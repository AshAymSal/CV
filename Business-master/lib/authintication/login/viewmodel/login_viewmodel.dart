import 'package:business/authintication/login/repo/login_repo.dart';
import 'package:business/core/network/local/cache_helper.dart';
import 'package:business/core/network/local/shared_preferences_service.dart';
import 'package:business/profile/model/profile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginViewModel = ChangeNotifierProvider(
    (ref) => LoginViewModel(ref.watch(sharedPreferencesServiceProvider)));

class LoginViewModel extends ChangeNotifier {
// Constructor
  LoginViewModel(this.sharedPreferencesService);

  /// Dummy
  TextEditingController emailController =
      TextEditingController(text: 'mohamedosama12w32@gmail.com');
  TextEditingController passwordController =
      TextEditingController(text: 'password');

  /// Real
  // TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();

  SharedPreferencesService sharedPreferencesService;

  /// Login user method
  Future<bool> userLogin() async {
    notifyListeners();
    ProfileModel? clientModel = await UserRepo.loginUserAccount(
      emailController.text,
      passwordController.text,
    );
    if (clientModel != null) {
      await sharedPreferencesService.setUserData(clientModel);
      CacheHelper.putStringData(
        key: "myToken",
        value: clientModel.rememberToken,
      );
      CacheHelper.putIntData(
        key: "id",
        value: clientModel.id,
      );
      return true;
    }

    notifyListeners();
    return false;
  }
}
