import 'package:business/helper/constanc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../custom_text.dart';

class CustomDropdownMenuWidget extends StatelessWidget {
  final String? value;
  final List<String>? list;
  final Function? onChange;

  CustomDropdownMenuWidget({
    this.value,
    this.list,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 20),
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        width: Get.width,
        child: DropdownButton<String>(
          value: value,
          icon: Icon(Icons.keyboard_arrow_down_outlined),
          iconSize: 24,
          elevation: 16,
          underline: SizedBox(),
          style: TextStyle(color: primaryColor),
          onChanged: onChange as void Function(String?)?,
          isExpanded: true,
          items: list!.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CustomText(
                  text: value,
                  alignment: Alignment.centerRight,
                  color: Colors.grey,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
