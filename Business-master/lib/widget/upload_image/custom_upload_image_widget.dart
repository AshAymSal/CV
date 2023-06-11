import 'dart:io';

import 'package:business/helper/constanc.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomUploadImageWidget extends StatelessWidget {
  final File? imageFile;
  final Function? press;
  final String? text;

  CustomUploadImageWidget({
    this.imageFile,
    this.press,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press as void Function()?,
      child: imageFile == null
          ? Container(
              width: Get.width,
              height: 100,
              child: DottedBorder(
                strokeWidth: 2,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload_outlined,
                        color: primaryColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        text!,
                        style: TextStyle(color: primaryColor),
                      ),
                    ],
                  ),
                ),
                color: primaryColor,
              ),
            )
          : Image.file(
              imageFile!,
              fit: BoxFit.fill,
              height: 130,
              width: Get.width / 2,
            ),
    );
  }
}
