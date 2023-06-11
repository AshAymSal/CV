import 'package:business/chatting/model/recent_chat_model.dart';
import 'package:business/chatting/providers/recent_chat_provider.dart';
import 'package:business/widget/custom_text.dart';
import 'package:business/widget/loading_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../components/recent_chat/recent_chat_component.dart';

class ResentChatScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: const Color(0xfff9f9f9)));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: const Color(0xfff9f9f9),
        centerTitle: true,
        title: CustomText(
          text: "الرسالة",
          fontSize: 17.0.sp,
          alignment: Alignment.center,
          fontWeight: FontWeight.w500,
          color: const Color(0xff000000),
        ),
      ),
      body: watch(recentChatStreamProvider).when(
        data: (data) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              RecentChatWidget(
                recentChatList: data,
              ),
            ],
          );
        },
        loading: () => LoadingStack(child: Container(), isLoading: true),
        error: (_, error) {
          print(error.toString());
          return Container(
            child: Center(
              child: Text("حدث مشكلة"),
            ),
          );
        },
      ),
    );
  }
}

class RecentChatWidget extends StatelessWidget {
  RecentChatWidget({required this.recentChatList});

  final List<RecentChatModel> recentChatList;

  @override
  Widget build(BuildContext context) {
    return recentChatList.length == 0
        ? Container(
            height: Get.height * 0.3,
            alignment: Alignment.bottomCenter,
            child: CustomText(
              text: "لا يوجد شات الان",
              fontWeight: FontWeight.w500,
              color: const Color(0xff666666),
            ),
          )
        : Column(
            children: [
              Consumer(
                builder: (BuildContext context,
                    T Function<T>(ProviderBase<Object?, T>) watch,
                    Widget? child) {
                  final viewModel = watch(recentChatProvider);
                  return AnimatedList(
                      initialItemCount:
                          viewModel.searchTextEditingController.text.isNotEmpty
                              ? viewModel.searchRecentChatList.length
                              : recentChatList.length,
                      shrinkWrap: true,
                      reverse: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index, animation) {
                        return InkWell(
                          onTap: () {
                            viewModel.navigationToChatMessageScreen(
                              context: context,
                              docIdChat: recentChatList[index].docId,
                              recentChatModel: recentChatList[index],
                            );
                          },
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(-1, 0),
                              end: Offset(0, 0),
                            ).animate(animation),
                            child: RecentChatComponent(
                              recentChatModel:
                                  viewModel.searchRecentChatList.length > 0
                                      ? viewModel.searchRecentChatList[index]
                                      : recentChatList[index],
                            ),
                          ),
                        );
                      });
                },
              )
            ],
          );
  }
}
