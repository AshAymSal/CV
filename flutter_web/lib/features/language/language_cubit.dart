import 'package:bloc/bloc.dart';

class LanguageCubit extends Cubit<String> {
  // LanguageCubit() : super(Locale('en'));

  String lang = 'en';

  LanguageCubit(super.initialState);

  void changeLanguage(String languageCode) {
    emit(languageCode);
  }
}
