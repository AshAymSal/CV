import 'package:business/authintication/register/viewmodel/create_account_view_model.dart';
import 'package:business/helper/constanc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class BirthDayWidget extends ConsumerWidget {
  const BirthDayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final viewModel = watch(createAccountViewModel);
    return GestureDetector(
      onTap: () {
        DatePicker.showDatePicker(context,
            showTitleActions: true,
            theme: DatePickerTheme(
              headerColor: primaryColor,
              backgroundColor: Colors.white,
              itemStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              doneStyle: TextStyle(color: Colors.white, fontSize: 16),
            ), onConfirm: (date) {
          viewModel.setBirthday('${date.year}-${date.month}-${date.day}');
        }, currentTime: DateTime.now(), locale: LocaleType.ar);
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
            )),
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                viewModel.birthDay == '' ? 'تاريخ الميلاد' : viewModel.birthDay,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.date_range_outlined,
              color: Colors.grey,
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
