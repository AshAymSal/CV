import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageProfile extends StatelessWidget {
  final double size;
  final bool active,
      borderWhite,
      coverBorder,
      backgroundShadow,
      yellowEditOverlay,
      featured;

  //final String? image;
  final double? width;
  final Color? color;
  final Widget? imageWidget;
  final Color? circularImage;

  ImageProfile({
    required this.size,
    //this.image,
    this.active = false,
    this.borderWhite = false,
    this.coverBorder = true,
    this.backgroundShadow = false,
    this.yellowEditOverlay = false,
    this.width,
    this.color,
    required this.imageWidget,
    this.circularImage,
    this.featured = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(150.h),
              border: Border.all(
                color: Colors.transparent,
                width: coverBorder ? 1.w : 0.0,
              ),
              boxShadow: [
                if (backgroundShadow)
                  BoxShadow(
                    color: const Color(0xFF757575).withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(150.h),
                border: !borderWhite
                    ? null
                    : Border.all(
                        color: color ?? Colors.white, //theme
                        width: width ?? 3.w,
                      ),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(150.h),
                  child: imageWidget),
            )),
      ],
    );
  }
}
