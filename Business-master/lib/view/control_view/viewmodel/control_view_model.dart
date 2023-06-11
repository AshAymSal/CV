import 'package:business/core/network/local/shared_preferences_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final controlViewModel = ChangeNotifierProvider<ControlViewModel>((ref) {
  return ControlViewModel(
    sharedPreferencesService: ref.watch(sharedPreferencesServiceProvider),
  );
});

class ControlViewModel with ChangeNotifier {
  bool isLoading = false;
  SharedPreferencesService sharedPreferencesService;

  ControlViewModel({required this.sharedPreferencesService});
  int selectIndex = 0;
  int? selectedMenuItemId;

  void changedItem(int value) {
    selectIndex = value;
    notifyListeners();
  }

  logout() async {
    await sharedPreferencesService.sharedPreferences.clear();
  }
}
