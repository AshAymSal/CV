import 'package:business/core/network/local/shared_preferences_service.dart';
import 'package:business/home/viewmodel/home_viewmodel.dart';
import 'package:business/home/widget/stories.dart';
import 'package:business/post/components/post_components.dart';
import 'package:business/widget/loading_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodel/home_viewmodel.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final viewModel = watch(homeViewModel);
    final sharedPreferencesViewModel = watch(sharedPreferencesServiceProvider);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
              sliver: SliverToBoxAdapter(
                child: LoadingStack(
                  isLoading: viewModel.isLoadingStories,
                  child: StoriesView(
                      currentUser: sharedPreferencesViewModel.getUserData()!),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return LoadingStack(
                    isLoading: viewModel.isLoadingPosts,
                    child: PostComponent(
                      post: viewModel.postModelList![index],
                      postIndex: index,
                      id: sharedPreferencesViewModel.getUserData()!.id!,
                    ),
                  );
                },
                childCount: viewModel.postModelList!.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
