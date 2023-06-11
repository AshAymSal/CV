import 'package:business/home/model/story_model.dart';
import 'package:business/home/widget/profile_avatar.dart';
import 'package:business/profile/model/profile_model.dart';
import 'package:business/widget/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoryCard extends StatelessWidget {
  final bool isAddStory;
  final ProfileModel? currentUser;
  final StoryModel? storyModel;
  final Function onPressed;
  final Function onPressedAddStory;

  const StoryCard({
    Key? key,
    this.isAddStory = false,
    this.currentUser,
    this.storyModel,
    required this.onPressed,
    required this.onPressedAddStory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: isAddStory
                ? storyModel == null
                    ? CachedNetworkImage(
                        imageUrl: currentUser!.personalImage!,
                        height: double.infinity,
                        width: 110.0,
                        fit: BoxFit.cover,
                      )
                    : storyModel?.userStories!.length != 0 &&
                            storyModel?.userStories![0].type == 1
                        ? CachedNetworkImage(
                            imageUrl:
                                storyModel!.userStories![0].images!.filename!,
                            height: double.infinity,
                            width: 110.0,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            height: double.infinity,
                            width: 110.0,
                            color: Colors.grey,
                            child: CustomText(
                              alignment: Alignment.center,
                              text: storyModel!.userStories?[0].body ?? '',
                              fontSize: 8.sp,
                            ),
                          )
                : storyModel?.userStories!.length != 0 &&
                        storyModel?.userStories![0].type == 1
                    ? CachedNetworkImage(
                        imageUrl: storyModel!.userStories![0].images!.filename!,
                        height: double.infinity,
                        width: 110.0,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: double.infinity,
                        width: 110.0,
                        color: Colors.grey,
                        child: CustomText(
                          alignment: Alignment.center,
                          text: storyModel!.userStories?[0].body ?? '',
                          fontSize: 8.sp,
                        ),
                      ),
          ),
          Container(
            height: double.infinity,
            width: 110.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          Positioned(
            top: 8.0,
            left: 8.0,
            child: isAddStory
                ? Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.add),
                      iconSize: 30.0,
                      color: Colors.black,
                      onPressed: () => onPressedAddStory(),
                    ),
                  )
                : ProfileAvatar(
                    imageUrl: storyModel!.personalImage,
                    hasBorder: true,
                  ),
          ),
          Positioned(
            bottom: 8.0,
            left: 8.0,
            right: 8.0,
            child: Text(
              isAddStory && storyModel == null
                  ? 'Add to Story'
                  : storyModel!.name!,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
