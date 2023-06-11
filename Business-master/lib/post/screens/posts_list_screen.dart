import 'package:business/post/components/post_components.dart';
import 'package:business/post/viewmodel/posts_viewmodel.dart';
import 'package:business/widget/custom_text.dart';
import 'package:business/widget/loading_stack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsListScreen extends ConsumerWidget {
  const PostsListScreen({
    Key? key,
    required this.modelType,
    required this.modelId,
  }) : super(key: key);
  final String? modelType;
  final int? modelId;

  @override
  Widget build(BuildContext context, watch) {
    final viewModel = watch(postsViewModel);
    return LoadingStack(
      isLoading: viewModel.isLoadingGetAllPosts,
      child: CustomScrollView(
        slivers: [
          viewModel.postsList!.length == 0
              ? SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: CustomText(
                      alignment: Alignment.center,
                      text: 'لا يوجد منشورات في الجروب',
                      fontSize: 22,
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return PostComponent(
                        post: viewModel.postsList![index],
                        id: modelId,
                        postIndex: index,
                      );
                    },
                    childCount: viewModel.postsList!.length,
                  ),
                ),
          SliverPadding(
            padding: EdgeInsets.only(bottom: 20),
          ),
        ],
      ),
    );
  }
}
