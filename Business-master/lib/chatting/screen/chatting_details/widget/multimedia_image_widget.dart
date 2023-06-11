import 'package:business/chatting/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MultimediaImageWidget extends StatelessWidget {
  final List<MessageModel> chatMessageList;
  final int index;
  final int clientId;
  final String receiverName;

  MultimediaImageWidget({
    required this.index,
    required this.clientId,
    required this.chatMessageList,
    required this.receiverName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(6.h),
      decoration: BoxDecoration(
          color: chatMessageList[index].clientId == clientId
              ? const Color(0xfffd6c57)
              : const Color(0xfff9f9f9),
          borderRadius: BorderRadius.only(

              /// if multimedia message from me remove border Raduis from topRight
              topRight: Radius.circular(
                  chatMessageList[index].clientId == clientId ? 0 : 20.0.h),

              /// if multimedia message from another person remove border Raduis from topLeft
              topLeft: Radius.circular(
                  chatMessageList[index].clientId != clientId ? 0 : 20.0.h),
              bottomRight: Radius.circular(20.0.h),
              bottomLeft: Radius.circular(20.0.h))),

      /// TODO : Add MODEL INTO PROVIDER
      child: InkWell(
        onTap: () {},
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.h),
          child: Image.network(
            chatMessageList[index].image!,
            width: Get.width * 0.63,
            height: 140.h,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
