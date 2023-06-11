import 'package:business/chatting/model/chatUserModel.dart';
import 'package:business/chatting/model/message_model.dart';
import 'package:business/chatting/screen/chatting_details/widget/chat_message_widget.dart';
import 'package:business/chatting/screen/chatting_details/widget/multimedia_image_widget.dart';
import 'package:business/core/widget/image_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatComponent extends StatelessWidget {
  final List<MessageModel> chatMessageList;
  final ChatUserModel? receiverModel;
  final int lengthMessageChatDoc;
  final int index;
  final int clientId;

  ChatComponent({
    required this.chatMessageList,
    required this.receiverModel,
    required this.lengthMessageChatDoc,
    required this.index,
    required this.clientId,
  });

  bool isMe = false;

  @override
  Widget build(BuildContext context) {
    ///after the reverse list the last element is the first
    ///check if the first element(last element befor reverse) give it null not exist index befor
    ///if not the first element give it the index befor

    int? indexBefor =
        index == lengthMessageChatDoc ? lengthMessageChatDoc : index + 1;
    isMe = chatMessageList[index].clientId == clientId;
    print(chatMessageList[index].message);
    return Column(
      children: [
        //add spcace after bloc of chat message for one person
        if (indexBefor != lengthMessageChatDoc &&
            chatMessageList[index].clientId !=
                chatMessageList[indexBefor].clientId)
          SizedBox(height: 18.h),
        // add spcace to the element one
        if (index == lengthMessageChatDoc - 1)
          SizedBox(
            height: 8.h,
            //Sizes.paddingChatMessage
          ),

        // ///we will change it to another check and another message
        // if (chatMessageList[index]["createAt"].toDate == DateTime.now())
        //   Column(
        //     children: [
        //       CustomText.h5(
        //         "Today 10:30",
        //         color: gt("disabledIconColor"),
        //         weight: FontStyles.fontWeightMedium,
        //       ),
        //       SizedBox(
        //         height: Sizes.paddingRatingStar,
        //       ),
        //     ],
        //   ),

        /// if me set it in the right else in the left
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //image the person whom you talk to
            if ((!isMe && indexBefor == lengthMessageChatDoc) ||
                (!isMe &&
                    chatMessageList[index].clientId !=
                        chatMessageList[indexBefor].clientId))
              Padding(
                padding: EdgeInsets.only(
                  right: 9.w,
                ),
                child: ImageProfile(
                  size: 65.h,
                  imageWidget: Image.network(
                    receiverModel!.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

            //book the size for if the sender is the same last sender
            if ((!isMe &&
                indexBefor != lengthMessageChatDoc &&
                chatMessageList[index].clientId ==
                    chatMessageList[indexBefor].clientId))
              Padding(
                padding: EdgeInsets.only(
                  right: 9.w,
                ),
                child: Container(
                  width: 65.h,
                ),
              ),

            ///if exist multiMediaImage do image message else do chat message
            chatMessageList[index].message != ""
                ? ChatMessageWidget(
                    index: index,
                    clientId: clientId,
                    chatMessageList: chatMessageList,
                    lengthMessageChatDoc: lengthMessageChatDoc,
                  )
                : MultimediaImageWidget(
                    index: index,
                    clientId: clientId,
                    chatMessageList: chatMessageList,
                    receiverName: receiverModel!.name,
                  ),
          ],
        ),
      ],
    );
  }
}
