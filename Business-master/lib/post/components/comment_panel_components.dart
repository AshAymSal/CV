import 'package:business/helper/constanc.dart';
import 'package:business/helper/functions.dart';
import 'package:business/model/comments_data_model.dart';
import 'package:business/post/model/post_model.dart';
import 'package:business/post/viewmodel/post_comments_viewmodel.dart';
import 'package:business/widget/button/custom_button.dart';
import 'package:business/widget/custom_text.dart';
import 'package:business/widget/custom_text_form_field_without_icon.dart';
import 'package:business/widget/dialog/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CommentsPanelComponents extends ConsumerWidget {
  final PostModel? post;
  final PostCommentsViewModel viewModel;
  final List<CommentsModel>? commentsModel;
  final int? postIndex;

  CommentsPanelComponents({
    required this.post,
    required this.commentsModel,
    required this.viewModel,
    required this.postIndex,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "الوصف ",
                          alignment: Alignment.bottomRight,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: post!.body!,
                          alignment: Alignment.bottomRight,
                          fontWeight: FontWeight.w200,
                        ),
                      ],
                    ),
                  ),

                  /// TO SAVE BUTTON
                  // SavedPostButton(),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              commentsModel!.length == 0
                  ? Expanded(child: Container())
                  : Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
                        shrinkWrap: true,
                        itemCount: commentsModel!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 30.0,
                                    backgroundImage: commentsModel![index]
                                                .user!
                                                .image ==
                                            null
                                        ? NetworkImage(
                                            'https://via.placeholder.com/150')
                                        : NetworkImage(
                                            commentsModel![index].user!.image!),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  title:
                                      Text(commentsModel![index].user!.name!),
                                  subtitle: Text(commentsModel![index].body!),
                                  trailing: PopupMenuWidget(
                                    viewModel: viewModel,
                                    post: post,
                                    commentsModel: commentsModel![index],
                                    commentsIndex: index,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                            ],
                          );
                        },
                      ),
                    ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 50,
                      child: CustomTextFormFieldWithoutIcon(
                        hint: 'اضف تعليق',
                        validator: (String? valid) {},
                        controller: viewModel.addCommentsController,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: CustomButton(
                      height: 50,
                      onPressed: () {
                        viewModel.addComment(context);
                      },
                      text: 'اضف',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PopupMenuWidget extends StatelessWidget {
  final PostModel? post;
  final PostCommentsViewModel? viewModel;
  final CommentsModel? commentsModel;
  final int? commentsIndex;

  PopupMenuWidget({
    this.post,
    this.viewModel,
    this.commentsModel,
    this.commentsIndex,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (details) async {
        double dx = details.globalPosition.dx;
        double dy = details.globalPosition.dy;
        double dx2 = MediaQuery.of(context).size.width - dx;
        double dy2 = MediaQuery.of(context).size.width - dy;
        await showMenu(
          context: context,
          position: RelativeRect.fromLTRB(
            dx,
            dy,
            dx2,
            dy2,
          ),
          items: await data(context, commentsModel!),
        );
      },
      child: IconButton(
        icon: FaIcon(FontAwesomeIcons.ellipsisV),
        onPressed: null,
      ),
    );
  }

  Future<MyPopupMenuItem<dynamic>> menuItemWidget({
    BuildContext? context,
    String? topText,
    String? buttonText,
    String? headerText,
    String? contentTextWithoutField,
    bool? showText = false,
    Function? onPressed,
    String? body,
    TextEditingController? controller,
  }) async {
    return MyPopupMenuItem(
      onClick: () async {
        Get.back();
        await showDialog(
            context: context!,
            builder: (ctxt) {
              return CustomInputDialog(
                width: Get.width,
                buttonText: topText,
                controller: controller,
                currentContent: body,
                onPressed: onPressed,
                headerText: headerText,
                showText: showText,
                contentTextWithoutField: contentTextWithoutField,
              );
            });
      },
      child: CustomText(
        text: buttonText,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Future data(BuildContext context, CommentsModel commentsModel) async {
    return commentsModel.myComment == 1
        ? [
            /// TODO : CHECK IF CURRENT USER OR NOT
            await menuItemWidget(
              context: context,
              topText: "تعديل التعليق",
              buttonText: "تعديل",
              onPressed: () {
                if (viewModel!.editCommentsController.text.length == 0) {
                  showToast(
                    msg: "التعليق فارغ",
                    color: colorBgToastError,
                  );
                } else {
                  viewModel!.editComment(
                    commentsId: commentsModel.id!,
                    commentsIndex: commentsIndex,
                  );
                }
              },
              headerText: "تعديل التعليق",
              controller: viewModel!.editCommentsController,
              body: commentsModel.body,
            ),

            /// TODO : CHECK IF CURRENT USER OR NOT
            await menuItemWidget(
              context: context,
              controller: viewModel!.editCommentsController,
              topText: "حذف",
              buttonText: "حذف التعليق",
              headerText: 'حذف التعليق',
              onPressed: () {
                viewModel!.deleteComment(
                  commentsId: commentsModel.id!,
                  commentsIndex: commentsIndex,
                );
              },
              showText: true,
              body: '',
              contentTextWithoutField: "هل تريد حقأ حذف التعليق",
            ),
          ]
        : [
            await menuItemWidget(
              context: context,
              topText: "ابلاغ الأن",
              buttonText: "أبلغ عن التعليق",
              headerText: 'أبلغ عن التعليق',
              body: '',
              onPressed: () {
                if (viewModel!.reportCommentsController.text.length == 0) {
                  showToast(
                    msg: "أبلغ عن الكومنت",
                    color: colorBgToastError,
                  );
                } else {
                  viewModel!.reportComment(
                    commentsId: commentsModel.id!,
                    commentsIndex: commentsIndex,
                  );
                }
              },
              controller: viewModel!.reportCommentsController,
            ),
          ];
  }
}

class MyPopupMenuItem<T> extends PopupMenuItem<T> {
  final Widget child;
  final Function onClick;

  MyPopupMenuItem({required this.child, required this.onClick})
      : super(child: child);

  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return MyPopupMenuItemState();
  }
}

class MyPopupMenuItemState<T, PopMenuItem>
    extends PopupMenuItemState<T, MyPopupMenuItem<T>> {
  @override
  void handleTap() {
    widget.onClick();
  }
}
