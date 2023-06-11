import 'dart:io';

import 'package:business/home/model/story_model.dart';
import 'package:business/home/utils/utils.dart';
import 'package:business/home/viewmodel/home_viewmodel.dart';
import 'package:business/home/widget/story_card.dart';
import 'package:business/profile/model/profile_model.dart';
import 'package:business/widget/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

class StoriesView extends ConsumerWidget {
  StoriesView({required this.currentUser});

  final ProfileModel currentUser;

  @override
  Widget build(BuildContext context, watch) {
    final viewModel = watch(homeViewModel);
    return Container(
      height: 200.0,
      color: Colors.white,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 8.0,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.storiesModelList!.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: StoryCard(
                isAddStory: true,
                currentUser: currentUser,
                onPressed: () {
                  if (viewModel.myStoriesModelList != null) {
                    showStoryDialog(
                      context,
                      viewModel.myStoriesModelList![0].userStories!,
                      true,
                      () {
                        Get.back();
                        viewModel.deleteStory(viewModel
                            .myStoriesModelList![0].userStories![0].id!);
                      },
                    );
                  }
                },
                storyModel: viewModel.myStoriesModelList?[0] ?? null,
                onPressedAddStory: () {
                  viewModel.navigationToAddStory();
                },
              ),
            );
          }
          return index < viewModel.storiesModelList!.length
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: StoryCard(
                    storyModel: viewModel.storiesModelList![index],
                    onPressed: () {
                      showStoryDialog(
                          context,
                          viewModel.storiesModelList![index].userStories!,
                          false,
                          null,
                      );
                    },
                    onPressedAddStory: () {},
                  ),
                )
              : SizedBox();
        },
      ),
    );
  }
}

showStoryDialog(context, List<UserStories> storyModel, bool isCurrentUser,
    Function? onPressedDelete) {
  StoryController controller = StoryController();
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: Stack(
        children: [
          Container(
            width: Get.width - 50.w,
            child: StoryView(
              storyItems: convertListToStoryItems(
                userStories: storyModel,
                controller: controller,


              ),
              onStoryShow: (s){
                print("Showing a story");
              },
              onComplete: () {
                print("Completed a cycle");
                sleep(const Duration(seconds:2));
                Get.back();
              },
              progressPosition: ProgressPosition.top,
              repeat: false,
              controller: controller,

            ),
          ),
          isCurrentUser
              ? Positioned(
                  top: 10,
                  left: 5,
                  child: GestureDetector(
                    onTap: () => onPressedDelete!(),
                    child: Container(
                      padding: EdgeInsets.only(top: 20.h),
                      child: CustomButton(
                        height: 40.h,
                        width: 120.w,
                        onPressed: null,
                        text: 'خذف',
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    ),
  );
}
Future sleep2() {
  return new Future.delayed(const Duration(seconds: 5), () => "5");
}