import 'package:business/profile/model/my_sports_model.dart';
import 'package:business/widget/button/custom_button.dart';
import 'package:business/widget/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class MySportsItemComponent extends ConsumerWidget {
  const MySportsItemComponent({
    Key? key,
    required this.sportsModel,
    required this.onPressDelete,
  }) : super(key: key);
  final Function onPressDelete;
  final MySportsModel sportsModel;

  @override
  Widget build(BuildContext context, watch) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Card(
          elevation: 10,
          child: Column(
            children: [
              Image.network(
                sportsModel.sport!.image!,
                width: Get.width,
                height: constraints.maxHeight / 2,
                fit: BoxFit.fitWidth,
              ),
              Spacer(),
              CustomText(
                alignment: Alignment.center,
                text: sportsModel.sport!.name,
              ),
              Spacer(),
              CustomButton(
                width: constraints.maxWidth / 2,
                onPressed: onPressDelete,
                text: "حذف",
              ),
            ],
          ),
        );
      },
    );
  }
}
