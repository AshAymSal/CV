import 'package:business/home/model/story_model.dart';
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

List<StoryItem> convertListToStoryItems({
  required List<UserStories> userStories,
  required StoryController controller,
}) {
  List<StoryItem> items = [];
  for (int i = 0; i < userStories.length; i++) {
    if (userStories[i].type == 0) {
      items.add(
        StoryItem.text(
          title: userStories[i].body!,
          backgroundColor: Colors.black,
        ),
      );
    } else if (userStories[i].type == 1) {
      items.add(
        StoryItem.pageImage(
          url: userStories[i].images!.filename!,
          controller: controller,
        ),
      );
    } else if (userStories[i].type == 2) {
      items.add(
        StoryItem.pageVideo(
          userStories[i].videos!.filename!,
          controller: controller,
        ),
      );
    }
  }
  return items;
}
