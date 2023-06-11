import 'package:business/core/network/local/cache_helper.dart';
import 'package:business/post/model/share_post_model.dart';
import 'package:business/post/repos/share_post_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final groupIdSelectedProvider = StateProvider<int?>((ref) => 0);
final postIdSelectedProvider = StateProvider<int?>((ref) => 0);

final getAllSharesPostViewModel = ChangeNotifierProvider.autoDispose(
  (ref) => GetAllSharesPostViewModel(
    ref.watch(groupIdSelectedProvider).state,
    ref.watch(postIdSelectedProvider).state,
  ),
);

class GetAllSharesPostViewModel extends ChangeNotifier {
  /// Constructor
  GetAllSharesPostViewModel(this.groupId, this.postId) {
    myToken = CacheHelper.getStringData(key: "myToken");
    getShares();
  }

  bool isLoading = false;
  String? myToken;
  int? groupId, postId;

  SharePostModel? sharePostModel;
  List<ShareDataModel>? shareDataModelList = [];

  getShares() async {
    isLoading = true;
    notifyListeners();

    /// TODO :
    // try {
    sharePostModel = await ShareLikePostRepo.getSharePost(
      token: myToken,
      groupId: groupId,
      postId: postId,
    );
    if (sharePostModel == null) {
      shareDataModelList = [];
    } else {
      shareDataModelList = sharePostModel!.shares;
    }
    // } catch (e) {
    //   showToast(msg: e.toString(), color: colorBgToastError);
    //   print(e.toString());
    // }
    isLoading = false;
    notifyListeners();
  }
}
