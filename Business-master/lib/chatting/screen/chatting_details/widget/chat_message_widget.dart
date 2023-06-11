import 'package:business/chatting/model/message_model.dart';
import 'package:business/core/widget/custom_png_icon.dart';
import 'package:business/helper/constanc.dart';
import 'package:business/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatMessageWidget extends StatelessWidget {
  final List<MessageModel> chatMessageList;
  final int lengthMessageChatDoc;
  final int index;
  final int clientId;

  ChatMessageWidget({
    required this.chatMessageList,
    required this.lengthMessageChatDoc,
    required this.index,
    required this.clientId,
  });

  bool isMe = false;

  @override
  Widget build(BuildContext context) {
    ///after the reverse l ist the last element is the first
    ///check if the first element(last element befor reverse) give it null not exist index befor
    ///if not the first element give it the index befor
    int? indexBefore =
        index == lengthMessageChatDoc ? lengthMessageChatDoc : index + 1;
    isMe = chatMessageList[index].clientId == clientId;
    return Container(
      width: Get.width * 0.66,
      margin: EdgeInsets.only(
        bottom: 12.h,
        left: isMe ? Get.width * 0.08 : 0,
        right: isMe ? 0 : Get.width * 0.08,
      ),
      padding: EdgeInsets.only(right: 15, left: 15, top: 15, bottom: 14),
      decoration: BoxDecoration(
          color: !isMe ? Colors.grey[200] : primaryColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0.h),

              ///if message from me and and last message for another person or me and first message in all chat remove border radius from bottomRight
              bottomRight: Radius.circular(
                  (isMe && indexBefore == lengthMessageChatDoc) ||
                          (isMe &&
                              chatMessageList[indexBefore].clientId != clientId)
                      ? 0
                      : 20.0.h),

              ///if message from not me and and last message not me too or not me and first message in all chat remove border radius from  topLeft
              topLeft: Radius.circular(
                  (!isMe && indexBefore == lengthMessageChatDoc) ||
                          (!isMe &&
                              chatMessageList[indexBefore].clientId !=
                                  chatMessageList[index].clientId)
                      ? 0
                      : 20.0.h),
              topRight: Radius.circular(20.0.h))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //message
          CustomText(
            text: chatMessageList[index].message!,
            fontSize: 17.0.sp,
            color: isMe ? Colors.white : const Color(0xff666666),
            fontWeight: FontWeight.w500,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomText(
                text: DateFormat.jm().format(
                  DateTime.fromMillisecondsSinceEpoch(
                      chatMessageList[index].createAt!),
                ),
                color: isMe ? Colors.white : primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 11.0.sp,
              ),
              SizedBox(
                width: 5.w,
              ),

              if (isMe && !chatMessageList[index].seen!)
                CustomImage.s6(
                  "assets/images/true.png",
                  color: const Color(0xffcccccc),
                ),
              //if read message add read icon to my message
              if (isMe && chatMessageList[index].seen!)
                CustomImage.s6(
                  "assets/images/read_message.png",
                  color: const Color(0xffcccccc),
                ),
            ],
          )
        ],
      ),
    );
  }
}
