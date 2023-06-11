import 'package:business/home/widget/profile_avatar.dart';
import 'package:business/profile/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostHeader extends StatelessWidget {
  final String? image;
  final String? name;
  final int? userId;

  const PostHeader({
    Key? key,
    required this.image,
    required this.name,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
            onTap: () {
              Get.to(() => ProfileScreen(
                    userId: userId,
                  ));
            },
            child: ProfileAvatar(
                imageUrl: image ?? 'https://via.placeholder.com/150')),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name ?? 'no name',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
