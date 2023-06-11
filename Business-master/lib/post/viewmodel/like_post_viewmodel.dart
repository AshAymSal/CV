import 'package:business/core/network/local/cache_helper.dart';
import 'package:business/helper/constanc.dart';
import 'package:business/helper/functions.dart';
import 'package:business/post/model/like_post_model.dart';
import 'package:business/post/repos/share_post_repo.dart';
import 'package:business/post/viewmodel/share_post_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getAllLikePostViewModel =
    ChangeNotifierProvider.autoDispose((ref) => GetAllLikePostViewModel(
          ref.watch(groupIdSelectedProvider).state,
          ref.watch(postIdSelectedProvider).state,
        ));

class GetAllLikePostViewModel extends ChangeNotifier {
  /// Constructor
  GetAllLikePostViewModel(this.groupId, this.postId) {
    myToken = CacheHelper.getStringData(key: "myToken");
    getLikes();
  }

  bool isLoading = false;
  String? myToken;
  int? groupId, postId;

  LikePostModel? likePostModel;
  List<LikesDataModel>? likeDataModelList;

  getLikes() async {
    isLoading = true;
    notifyListeners();
    try {
      print(postId);
      likePostModel = await ShareLikePostRepo.getLikesPost(
        token: myToken,
        postId: postId,
        modelType: "post",
      );
      if (likePostModel != null) {
        likeDataModelList = likePostModel!.likes;
      }
    } catch (e) {
      showToast(msg: e.toString(), color: colorBgToastError);
      print(e.toString());
    }
    isLoading = false;
    notifyListeners();
  }
}
