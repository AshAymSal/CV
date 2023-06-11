import 'package:business/chatting/model/recent_chat_model.dart';
import 'package:business/chatting/providers/chatting_details_provider.dart';
import 'package:business/helper/constanc.dart';
import 'package:business/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InsertMessageComponent extends ConsumerWidget {
  final TextEditingController insertMessageController;
  final String docIdChat;
  final RecentChatModel recentChatModel;

  InsertMessageComponent({
    required this.insertMessageController,
    required this.docIdChat,
    required this.recentChatModel,
  });
  @override
  Widget build(BuildContext context, watch) {
    final viewModel = watch(chattingDetailsProvider(recentChatModel));
    return Container(
      height: 100.h,
      padding: EdgeInsets.only(bottom: 20.h),
      alignment: Alignment.center,
      color: const Color(0xfff9f9f9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 15.w,
          ),
          // GestureDetector(
          //   onTap: () {
          //     viewModel.openGallery(
          //       docIdChat: docIdChat,
          //       context: context,
          //     );
          //   },
          //   child: Transform.rotate(
          //     angle: 150 * math.pi / 180,
          //     child: Icon(
          //       Icons.attachment,
          //       color: Color(0xff999999),
          //       size: 32.h,
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   width: 4.8.w,
          // ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 9.h),
              height: 77.h,
              alignment: Alignment.center,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                reverse: true,
                child: CustomTextFormField(
                  height: 62.h,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 13.0.h,
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  controller: insertMessageController,
                  onChanged: (String? value) {
                    if (value!.length % 2 == 0) {
                      viewModel.setClientWriteNow(
                        docId: docIdChat,
                      );
                    }
                  },
                  fillColor: Colors.white,
                  borderRaduisSize: 30.0.h,
                  hint: 'اكتب الرسالة .. ',
                ),
              ),
            ),
          ),
          SizedBox(
            width: 7.w,
          ),
          IconButton(
            color: insertMessageController.text.isEmpty
                ? Color(0xff999999)
                : primaryColor,
            padding: EdgeInsets.all(0),
            onPressed: insertMessageController.text.isEmpty
                ? null
                : () async {
                    viewModel.setClientWriteNow(
                      docId: docIdChat,
                      closeWriteNow: true,
                    );
                    await viewModel.setMessageInChat(
                      docIdChat: docIdChat,
                      isMultiMedia: false,
                    );
                  },
            icon: Icon(Icons.send, size: 32.h),
          ),
          SizedBox(
            width: 7.w,
          ),
        ],
      ),
    );
  }
}
