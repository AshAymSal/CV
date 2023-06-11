import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ImageContent extends StatelessWidget {
  ImageContent({
    required this.image,
    required this.onTap,
  });

  final String? image;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            image != null
                ? const SizedBox.shrink()
                : const SizedBox(height: 6.0),
          ],
        ),
        GestureDetector(
          onTap: () => onTap,
          child: Container(
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: CachedNetworkImage(
                imageUrl: image!,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
