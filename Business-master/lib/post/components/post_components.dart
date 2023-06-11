import 'package:business/post/components/post_header.dart';
import 'package:business/post/components/reaction_model.dart';
import 'package:business/post/model/post_model.dart';
import 'package:business/post/screens/like_view.dart';
import 'package:business/post/screens/post_comments_view.dart';
import 'package:business/post/screens/share_view.dart';
import 'package:business/post/viewmodel/posts_viewmodel.dart';
import 'package:business/post/viewmodel/share_post_viewmodel.dart';
import 'package:business/widget/custom_text.dart';
import 'package:business/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'image_content.dart';

/// Sending Post Model
/// Sending id
class PostComponent extends StatelessWidget {
  final PostModel post;
  final int? id;
  final int? postIndex;

  const PostComponent({
    Key? key,
    required this.post,
    required this.id,
    required this.postIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
      vertical: 5.0,
      horizontal: 0,
    ),
      child: Card(
        elevation: 3.0,
        color: Colors.grey.shade50,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(5.0.r),
        ),
        child: Column(
          children: [
            /// NAME AND IMAGE
            PostHeader(
              name: post.userPostModel?.name ?? '',
              image: post.images == null ? post.images![0].filename : null,
              userId: post.userPostModel?.id,
            ),
            const SizedBox(height: 20.0),
            CustomText(
              text: post.body ?? '',
              alignment: Alignment.topRight,
              fontWeight: FontWeight.w300,
            ),

            /// Image view
            post.images!.length == 0
                ? const SizedBox.shrink()
                : ImageContent(
                    image: post.images![0].filename ?? '',
                    onTap: () {
                      Get.to(() => PostCommentsView(post: post));
                    },
                  ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: _PostStats(
                postIndex: postIndex,
                post: post,
                id: id,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostStats extends StatelessWidget {
  final PostModel post;
  final int? id;
  final int? postIndex;

  const _PostStats({
    Key? key,
    required this.post,
    required this.id,
    required this.postIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context,
          T Function<T>(ProviderBase<Object, T>) watch, Widget? child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Like Content
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ///deal with likes in like post viewModel
                FittedBox(
                  child: FlutterReactionButtonCheck(
                    onReactionChanged: (reaction, index, isChecked) {
                      if (post.reactNum != index) {
                        watch(postsViewModel)
                            .addLike(index, post.id, postIndex!);
                      } else {
                        watch(postsViewModel).addLike(99, post.id, postIndex!);
                      }
                    },
                    reactions: reactions,
                    initialReaction: post.reactNum != 99
                        ? reactions[post.reactNum]
                        : defaultInitialReaction,
                    selectedReaction: reactions[
                        int.parse(post.reactNum.toString()) == 99
                            ? 0
                            : int.parse(post.reactNum.toString())],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    watch(groupIdSelectedProvider).state = id;
                    watch(postIdSelectedProvider).state = post.id;
                    Get.to(() => GroupLikeView());
                  },
                  child: CustomText(
                    alignment: Alignment.topRight,
                    text: '${post.likesNum} إعجاب ',
                    color: Colors.grey[500],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(
                      () => PostCommentsView(
                        post: post,
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      _PostButton(
                        path: "assets/images/reacts/comments.png",
                        label: 'تعليق',
                        onTap: () {
                          Get.to(
                            () => PostCommentsView(post: post),
                          );
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        alignment: Alignment.topRight,
                        text: '${post.commentsNum} تعليق ',
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                _PostButton(
                    path: "assets/images/reacts/share.png",
                    label: 'مشاركة',
                    onTap: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: CustomText(text: "هل تريد مشاركة المنشور"),
                          content: CustomTextFormField(
                            hint: 'هل تريد قول شئ',
                            controller:
                                watch(postsViewModel).sharePostController,
                            validator: (String? value) {},
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('الغاء'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, '');

                                watch(postsViewModel)
                                    .sharePost(postId: post.id!);
                              },
                              child: const Text('شارك'),
                            ),
                          ],
                        ),
                      );
                    }),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    watch(groupIdSelectedProvider).state = id;
                    watch(postIdSelectedProvider).state = post.id;
                    Get.to(() => GroupShareView());
                  },
                  child: CustomText(
                    alignment: Alignment.topRight,
                    text: '${post.sharesNum} مشاركة ',
                    color: Colors.grey[500],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _PostButton extends StatelessWidget {
  final String path;
  final String label;
  final Function onTap;

  const _PostButton({
    Key? key,
    required this.path,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: InkWell(
        onTap: () => onTap(),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(path, height: 20),
              const SizedBox(width: 4.0),
              CustomText(
                text: label,
                fontSize: 12,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
