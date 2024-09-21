import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/features/language/lang.dart';
import 'package:flutter_web/features/language/language_cubit.dart';

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({super.key});

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  String val = 'en';
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${AppLocalizations.of(context).translate('language')} ',
          style: TextStyle(fontSize: 18),
        ),
        DropdownButton<String>(
          items: <String>['en', 'ar'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          value: val,
          onChanged: (value) {
            setState(() {
              val = value!;
            });
            BlocProvider.of<LanguageCubit>(context).changeLanguage(value!);
          },
        )
      ],
    );
  }
}
