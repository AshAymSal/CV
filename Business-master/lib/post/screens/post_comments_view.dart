import 'package:business/post/components/comment_panel_components.dart';
import 'package:business/post/model/post_model.dart';
import 'package:business/post/viewmodel/post_comments_viewmodel.dart';
import 'package:business/widget/loading_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PostCommentsView extends ConsumerWidget {
  final PostModel? post;
  final int? postIndex;

  PostCommentsView({
    this.post,
    this.postIndex,
  });

  final panelController = PanelController();

  @override
  Widget build(BuildContext context, watch) {
    final viewModel = watch(postCommentsViewModel);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,// What is the heck is that
          appBar: AppBar(
              elevation: 0.0,
              titleSpacing: 0.0,
              centerTitle: true,
              backgroundColor: Colors.transparent,

              leading: IconButton(
                color: Colors.black,
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_forward_ios_sharp),
              )
          ),
          body: LoadingStack(
            isLoading: viewModel.isLoading,
            child: post!.images!.length == 0
                ? Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Expanded(
                        child: CommentsPanelComponents(
                          post: post,
                          commentsModel: viewModel.commentsModelList,
                          viewModel: viewModel,
                          postIndex: postIndex,
                        ),
                      ),
                    ],
                  )
                : SlidingUpPanel(
                    maxHeight: Get.height * .5,
                    minHeight: Get.height * .5,
                    // parallaxEnabled: true,
                    controller: panelController,
                    color: Colors.transparent,
                    body: PageView.builder(
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Image.network(
                                  post!.images![index].filename!,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(),
                            ),
                          ],
                        );
                      },
                      itemCount: post!.images!.length,
                      onPageChanged: viewModel.changePageIndex,
                    ),
                    panelBuilder: (ScrollController scrollController) {
                      return CommentsPanelComponents(
                        post: post,
                        commentsModel: viewModel.commentsModelList,
                        viewModel: viewModel,
                        postIndex: postIndex,
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
