import 'package:business/core/network/local/cache_helper.dart';
import 'package:business/helper/constanc.dart';
import 'package:business/helper/functions.dart';
import 'package:business/model/comments_data_model.dart';
import 'package:business/post/repos/comments_repo.dart';
import 'package:business/post/viewmodel/models_viewmodel.dart';
import 'package:business/post/viewmodel/posts_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

final postCommentsViewModel = ChangeNotifierProvider(
  (ref) => PostCommentsViewModel(
    postId: ref.watch(postIdProvider).state!,
  ),
);

class PostCommentsViewModel extends ChangeNotifier {
  /// Constructor
  PostCommentsViewModel({this.postId}) {
    myToken = CacheHelper.getStringData(key: "myToken");
    getComments();
  }

  bool isLoading = false;
  bool isLoadingEdit = false;
  int? postId;
  int imageIndex = 0;
  String? myToken;

  /// group Members var
  List<CommentsModel>? commentsModelList = [];

  /// Controller
  TextEditingController addCommentsController = TextEditingController();
  TextEditingController editCommentsController = TextEditingController();
  TextEditingController reportCommentsController = TextEditingController();

  changePageIndex(int index) {
    imageIndex = index;
    notifyListeners();
  }

  /// Get all comments
  Future getComments() async {
    isLoading = true;
    notifyListeners();
    try {
      commentsModelList = await CommentsRepo.getPostComments(
        token: myToken,
        modelId: postId,
        modelType: 'post',
      );
    } catch (e) {
      showToast(msg: e.toString(), color: colorBgToastError);
      print(e.toString());
    }
    isLoading = false;
    notifyListeners();
  }

  /// Add Comment
  Future addComment(BuildContext context) async {
    try {
      CommentsModel? commentsModel = await CommentsRepo.addComments(
        token: myToken,
        modelId: postId,
        modelType: 'post',
        body: addCommentsController.text,
      );

      if (commentsModel != null) {
        commentsModelList!.add(commentsModel);
        addCommentsController.text = '';
      }
      context.read(postsViewModel).increaseDecreaseCommentCount(postId);

      notifyListeners();
    } catch (e) {
      showToast(msg: e.toString(), color: colorBgToastError);
      print(e.toString());
    }
  }

  Future editComment({int? commentsId, int? commentsIndex}) async {
    try {
      Get.back();
      bool? result = await CommentsRepo.editComments(
        token: myToken,
        commentId: commentsId,
        body: editCommentsController.text,
      );
      if (result!) {
        commentsModelList![commentsIndex!] =
            commentsModelList![commentsIndex].copyWith(
          body: editCommentsController.text,
        );
      }
    } catch (e) {
      showToast(msg: e.toString(), color: colorBgToastError);
      print(e.toString());
    }
    notifyListeners();
  }

  Future deleteComment({int? commentsId, int? commentsIndex}) async {
    try {
      Get.back();
      print(commentsIndex);
      print(commentsId);
      bool? result = await CommentsRepo.deleteComments(
        token: myToken,
        commentId: commentsId,
      );
      if (result!) {
        commentsModelList!.removeAt(commentsIndex!);
      }
    } catch (e) {
      showToast(msg: e.toString(), color: colorBgToastError);
      print(e.toString());
    }
    notifyListeners();
  }

  Future reportComment({int? commentsId, int? commentsIndex}) async {
    print(commentsId);
    print(myToken);
    try {
      Get.back();
      await CommentsRepo.reportComments(
        token: myToken,
        commentId: commentsId,
        modelType: 'post',
        body: reportCommentsController.text,
      );
    } catch (e) {
      showToast(msg: e.toString(), color: colorBgToastError);
      print(e.toString());
    }
    notifyListeners();
  }
}
