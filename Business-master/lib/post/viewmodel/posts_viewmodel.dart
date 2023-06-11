import 'package:business/core/network/local/cache_helper.dart';
import 'package:business/helper/constanc.dart';
import 'package:business/helper/functions.dart';
import 'package:business/post/model/post_model.dart';
import 'package:business/post/repos/posts_repo.dart';
import 'package:business/post/viewmodel/models_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postsViewModel = ChangeNotifierProvider.autoDispose(
  (ref) => PostsViewModel(
    modelId: ref.read(modelPostIdProvider).state,
    modelType: ref.read(modelPostTypeProvider).state,
  ),
);

class PostsViewModel extends ChangeNotifier {
  /// Constructor
  PostsViewModel({required this.modelType, required this.modelId}) {
    myToken = CacheHelper.getStringData(key: "myToken");
    getAllPosts();
  }

  int? modelId;
  String? modelType, myToken;

  bool isLoadingGetAllPosts = false;

  TextEditingController? sharePostController = TextEditingController();

  List<PostModel>? postsList = [];

  Future getAllPosts() async {
    isLoadingGetAllPosts = true;
    notifyListeners();
    postsList = await PostsRepo.getAllPosts(
      token: myToken!,
      modelType: modelType,
      modelId: modelId,
    );

    isLoadingGetAllPosts = false;
    notifyListeners();
  }

  /// Start Like Section
  void addLike(int reactIndex, postId, int postIndex) async {
    try {
      var reactId = await PostsRepo.addLike(
        token: myToken,
        postId: postId,
        modelType: "post",
        reactId: reactIndex,
      );
      if (reactId == null) {
        postsList![postIndex] = postsList![postIndex].copyWith(reactNum: 99);
      } else {
        postsList![postIndex] =
            postsList![postIndex].copyWith(reactNum: reactId);
      }
    } catch (e) {
      showToast(msg: e.toString(), color: colorBgToastError);
      print(e.toString());
    }
    notifyListeners();
  }

  /// End Like Section
  Future sharePost({
    int? postId,
  }) async {
    try {
      await PostsRepo.sharePost(
        token: myToken,
        postId: postId,
        body: sharePostController!.text,
      );
    } catch (e) {
      showToast(msg: e.toString(), color: colorBgToastError);
      print(e.toString());
    }
    notifyListeners();
  }

  /// Comments
  void increaseDecreaseCommentCount(int? postId) {
    postsList!.forEach((e) {
      if (e.id == postId) {
        e.commentsNum = e.commentsNum! + 1;
      }
    });
    notifyListeners();
  }
}
