import 'package:business/core/network/end_points.dart';
import 'package:business/core/network/remote/api_caller.dart';
import 'package:business/home/model/story_model.dart';
import 'package:business/post/model/post_model.dart';

class HomeRepo {
  static Future<List<PostModel>> getPostsData({
    required String? token,
  }) async {
    return await ApiCaller.instance.requestPost(
          homePostsPath,
          (data) {
            return List<PostModel>.from(data["posts"].map(
              (post) => PostModel.fromJson(post),
            ));
          },
          token: token,
          body: <String, dynamic>{
            "token": token,
          },
        ) ??
        [];
  }

  static Future<List> getStories({
    required String? token,
  }) async {
    return await ApiCaller.instance.requestPost(
          homeStoriesPath,
          (data) {
            return [
              data["stories"] != null //Mina Temp and go back for ["my_stories"] 8/1/2022
                  ? List<StoryModel>.from(data["stories"].map(//Mina Temp and go back for ["my_stories"]
                      (post) => StoryModel.fromJson(post),
                    ))
                  : null,
              List<StoryModel>.from(data["stories"].map(//Mina Temp and go back for ["all_stories"]
                (post) => StoryModel.fromJson(post),
              ))
            ];
          },
          token: token,
          body: <String, dynamic>{
            "token": token,
          },
        ) ??
        [];
  }

  static deleteStory(String storyId) async {
    return await ApiCaller.instance.requestPost(
          deleteStoryPath,
          (data) {
            print(data);
          },
          body: <String, dynamic>{
            "story_id": storyId,
            "lang": "ar",
          },
        ) ??
        [];
  }
}
