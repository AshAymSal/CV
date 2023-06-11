import 'package:business/profile/model/hobbies_model.dart';
import 'package:business/widget/button/custom_button.dart';
import 'package:business/widget/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class AllHobbiesItemComponent extends ConsumerWidget {
  const AllHobbiesItemComponent({
    Key? key,
    required this.hobbiesMode,
    required this.onPressAll,
  }) : super(key: key);
  final Function onPressAll;
  final HobbiesModel hobbiesMode;

  @override
  Widget build(BuildContext context, watch) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Card(
          elevation: 10,
          child: Column(
            children: [
              Image.network(
                hobbiesMode.image!,
                width: Get.width,
                height: constraints.maxHeight / 2,
                fit: BoxFit.fitWidth,
              ),
              Spacer(),
              CustomText(
                alignment: Alignment.center,
                text: hobbiesMode.name,
              ),
              Spacer(),
              CustomButton(
                width: constraints.maxWidth / 2,
                onPressed: onPressAll,
                text: "اضافة",
              ),
            ],
          ),
        );
      },
    );
  }
}
