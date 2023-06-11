import 'package:business/chatting/model/recent_chat_model.dart';
import 'package:business/chatting/providers/recent_chat_provider.dart';
import 'package:business/core/widget/image_profile.dart';
import 'package:business/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

class RecentChatComponent extends ConsumerWidget {
  RecentChatComponent({required this.recentChatModel});

  final RecentChatModel recentChatModel;

  @override
  Widget build(BuildContext context, watch) {
    final countStream = watch(unreadStreamProvider(recentChatModel));
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ImageProfile(
                size: 65.h,
                imageWidget: Image.network(
                  recentChatModel.receiverData!.image,
                  fit: BoxFit.cover,
                ),
                circularImage: Colors.white,
              ),
              SizedBox(
                width: 15.w,
              ),
              Container(
                width: 260.w,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: CustomText(
                                text: recentChatModel.receiverData!.name,
                                fontSize: 17.0.sp,
                                fontWeight: FontWeight.w500,
                                alignment: Alignment.centerRight,
                                maxLine: 1,
                              ),
                            ),
                            CustomText(
                              text: timeago.format(
                                recentChatModel.recentDate!.toDate(),
                                locale: 'en',
                              ),
                              fontSize: 11.0.sp,
                              color: const Color(0xff666666),
                              fontWeight: FontWeight.w400,
                            ),
                          ]),
                      SizedBox(
                        height: 7.h,
                      ),
                      //COMMENT
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: CustomText(
                              text: recentChatModel.lastMessage ?? '',
                              fontSize: 14.0.sp,
                              color: const Color(0xff666666),
                              alignment: Alignment.centerRight,
                              maxLine: 1,
                            )),
                            SizedBox(
                              width: 3.w,
                            ),
                            countStream.when(
                              data: (data) {
                                if (data.unreadCount! > 0)
                                  return CircleAvatar(
                                    backgroundColor: const Color(0xfffd6c57),
                                    radius: 11.0.h,
                                    child: CustomText(
                                      text: data.unreadCount.toString(),
                                      fontSize: 17.sp,
                                      color: Colors.white,
                                    ),
                                  );
                                return SizedBox();
                              },
                              loading: () => Container(),
                              error: (_, __) => Container(),
                            ),
                          ]),
                    ]),
              ),
            ],
          ),
          Divider(
            color: const Color(0xffe2e2e2),
          )
        ],
      ),
    );
  }
}
