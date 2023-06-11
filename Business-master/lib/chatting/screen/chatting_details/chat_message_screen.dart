import 'package:business/chatting/components/chatting_details/chat_component.dart';
import 'package:business/chatting/components/chatting_details/insert_message_component.dart';
import 'package:business/chatting/components/chatting_details/typing_component.dart';
import 'package:business/chatting/model/recent_chat_model.dart';
import 'package:business/chatting/providers/chatting_details_provider.dart';
import 'package:business/widget/custom_text.dart';
import 'package:business/widget/loading_stack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatMessageScreen extends ConsumerWidget {
  final RecentChatModel? recentChatModel;

  ChatMessageScreen({
    required this.recentChatModel,
  });

  @override
  Widget build(BuildContext context, watch) {
    final viewModel = watch(chattingDetailsProvider(recentChatModel!));

    return WillPopScope(
      onWillPop: () async {
        viewModel.setClientWriteNow(
          docId: recentChatModel!.docId,
          closeWriteNow: true,
        );
        Get.back();
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar: AppBar(
          elevation: 0.5,
          leading: GestureDetector(
            onTap: () {
              viewModel.setClientWriteNow(
                docId: recentChatModel!.docId,
                closeWriteNow: true,
              );
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_outlined,
              color: const Color(0xff000000),
            ),
          ),
          backgroundColor: const Color(0xfff9f9f9),
          centerTitle: true,
          title: watch(checkIfUserActiveStream(
                  recentChatModel!.receiverData!.userId))
              .when(
            data: (data) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                data.active == null
                    ? SizedBox.shrink()
                    : Container(
                        width: 12.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.0.r),
                          color: data.active!
                              ? const Color(0xff36bd66)
                              : Colors.grey,
                          border: Border.all(
                            color: data.active!
                                ? const Color(0xffffffff)
                                : Colors.grey,
                            width: 1.w,
                          ),
                        ),
                      ),
                SizedBox(
                  width: 11.w,
                ),
                CustomText(
                  text: recentChatModel!.receiverData!.name,
                  fontSize: 17.0.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff000000),
                ),
              ],
            ),
            loading: () => LoadingStack(child: Container(), isLoading: true),
            error: (_, __) => LoadingStack(child: Container(), isLoading: true),
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: [
              Expanded(
                child: Consumer(
                  builder: (BuildContext context,
                      T Function<T>(ProviderBase<Object?, T>) watch,
                      Widget? child) {
                    final stream = watch(
                      getChatMessageStream(recentChatModel!),
                    );
                    return stream.when(
                      data: (data) {
                        return data.length == 0
                            ? CustomText(
                                text: 'لا يوجد شات الي الان',
                                fontSize: 17.sp,
                                alignment: Alignment.center,
                              )
                            : ListView.builder(
                                reverse: true,
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  if (data[index].seen == false &&
                                      data[index].clientId !=
                                          recentChatModel!.clientData!.userId) {
                                    watch(updateMessageSeen(data[index]));
                                  }

                                  if (data[index].message ==
                                          recentChatModel!.lastMessage ||
                                      data[index].image ==
                                          recentChatModel!.lastMessage) {
                                    viewModel.updateSeen();
                                  }
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: Get.width * 0.03,
                                        ),
                                        child: Column(
                                          children: [
                                            ChatComponent(
                                              chatMessageList: data,
                                              lengthMessageChatDoc: data.length,
                                              index: index,
                                              clientId: viewModel.clientId,
                                              receiverModel: recentChatModel!
                                                  .receiverData!,
                                            ),
                                          ],
                                        ),
                                      ),

                                      //typing indicator
                                      if (index == 0)
                                        Consumer(
                                          builder: (BuildContext context,
                                              T Function<T>(
                                                      ProviderBase<Object?, T>)
                                                  watch,
                                              Widget? child) {
                                            return watch(
                                                    getStatusWriteNowStream)
                                                .when(
                                                    data: (data) => data
                                                        ? TypingComponent(
                                                            receiverImage:
                                                                recentChatModel!
                                                                    .receiverData!
                                                                    .image,
                                                          )
                                                        : SizedBox(),
                                                    loading: () => LoadingStack(
                                                        child: Container(),
                                                        isLoading: true),
                                                    error: (_, __) =>
                                                        SizedBox.shrink());
                                          },
                                        ),
                                      if (index == 0 &&
                                          viewModel.isUploadingChatImage)
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: Get.width * 0.03,
                                          ),
                                          alignment: Alignment.centerRight,
                                          child: LoadingStack(
                                              child: Container(),
                                              isLoading: true),
                                        ),
                                    ],
                                  );
                                },
                              );
                      },
                      loading: () =>
                          LoadingStack(child: Container(), isLoading: true),
                      error: (_, __) =>
                          LoadingStack(child: Container(), isLoading: true),
                    );
                  },
                ),
              ),
              Column(
                children: [
                  Container(
                      color: const Color(0xfff9f9f9),
                      height: 1,
                      child: Divider(
                        color: const Color(0xffe2e2e2),
                      )),
                  InsertMessageComponent(
                    insertMessageController: viewModel.insertMessageController,
                    docIdChat: recentChatModel!.docId!,
                    recentChatModel: recentChatModel!,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
