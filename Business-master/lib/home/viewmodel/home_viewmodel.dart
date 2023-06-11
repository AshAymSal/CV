import 'package:business/core/network/local/cache_helper.dart';
import 'package:business/helper/constanc.dart';
import 'package:business/helper/functions.dart';
import 'package:business/home/model/story_model.dart';
import 'package:business/home/repos/home_repo.dart';
import 'package:business/home/screens/add_story_screen.dart';
import 'package:business/post/model/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

final homeViewModel = ChangeNotifierProvider(
  (ref) => HomeViewModel(),
);

class HomeViewModel extends ChangeNotifier {
  /// Constructor
  HomeViewModel() {
    myToken = CacheHelper.getStringData(key: "myToken");
    gePostsData();
    getStoriesData();
  }

  bool isLoadingPosts = false;
  bool isLoadingStories = false;
  String? myToken;

  /// group Members var
  List<PostModel>? postModelList = [];
  List<StoryModel>? storiesModelList = [];
  List<StoryModel>? myStoriesModelList;

  Future gePostsData() async {
    isLoadingPosts = true;
    notifyListeners();
    try {
      postModelList = await HomeRepo.getPostsData(
        token: myToken,
      );
    } catch (e) {
      showToast(msg: e.toString(), color: colorBgToastError);
      print(e.toString());
    }
    isLoadingPosts = false;
    notifyListeners();
  }

  Future getStoriesData() async {
    isLoadingStories = true;
    notifyListeners();
    try {
      var result = await HomeRepo.getStories(
        token: myToken,
      );
      myStoriesModelList = result.first;
      storiesModelList = result.last;
    } catch (e) {
      showToast(msg: e.toString(), color: colorBgToastError);
      print(e.toString());
    }
    isLoadingStories = false;
    notifyListeners();
  }

  Future navigationToAddStory() async {
    Get.to(() => AddStoryScreen());
  }

  deleteStory(String storyId) async {
    try {
      await HomeRepo.deleteStory(storyId);
    } catch (e) {
      showToast(msg: e.toString(), color: colorBgToastError);
      print(e.toString());
    }
    getStoriesData();
  }
}
