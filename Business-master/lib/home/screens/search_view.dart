import 'package:business/helper/constanc.dart';
import 'package:business/widget/custom_text.dart';
import 'package:business/widget/custom_text_form_field_withour_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          titleSpacing: 0.0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: CustomText(
              text: 'البحث',
              alignment: Alignment.center,
              fontSize: 24,
              color: primaryColor,
            ),
          ),
          actions: [IconButton(
            color: Colors.black,
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_forward_ios_sharp),
          )],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: CustomTextFormFieldWithoutBorder(
                hint: 'بتدور على ايه ؟',
                onSave: (String? s) {},
                validator: (String? valid) {},
                icons: Icons.search,
              ),
            )
          ],
        ),
      ),
    );
  }
}
