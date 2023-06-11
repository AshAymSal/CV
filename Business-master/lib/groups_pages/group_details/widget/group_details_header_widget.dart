// import 'package:business/groups_pages/group_details/model/group_details_data_model.dart';
// import 'package:business/helper/constanc.dart';
// import 'package:business/helper/functions.dart';
// import 'package:business/post/screens/add_post_to_group_view.dart';
// import 'package:business/widget/button/custom_button.dart';
// import 'package:business/widget/custom_add_post_widget.dart';
// import 'package:business/widget/custom_border_button.dart';
// import 'package:business/widget/custom_text.dart';
// import 'package:business/widget/loading_stack.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class GroupDetailsHeaderWidget extends StatelessWidget {
//   const GroupDetailsHeaderWidget({
//     required this.enteredGroup,
//     required this.groupId,
//     required this.groupDetailsModel,
//     required this.isLoading,
//     required this.joinPressButton,
//     required this.isPage,
//   });
//
//   final int? enteredGroup;
//   final int? groupId;
//   final GroupDetailsModel? groupDetailsModel;
//   final bool? isLoading;
//   final Function? joinPressButton;
//   final bool? isPage;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           height: 300,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               fit: BoxFit.cover,
//               image: NetworkImage(groupDetailsModel!.details!.coverImage != null
//                   ? groupDetailsModel!.details!.coverImage!
//                   : 'https://th.bing.com/th/id/Rf008462944c9cd857ba05200ac1f55ca?rik=54TPeGvcaUlqVw&pid=ImgRaw'),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CustomText(
//                       alignment: Alignment.topRight,
//                       fontSize: 24,
//                       text: groupDetailsModel!.details!.name.toString(),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     CustomText(
//                       alignment: Alignment.topRight,
//                       fontSize: 16,
//                       color: Colors.grey,
//                       text:
//                           '${groupDetailsModel!.details!.membersCount}   عضو ',
//                     ),
//                   ],
//                 ),
//               ),
//               LoadingStack(
//                 isLoading: isLoading!,
//                 child: Container(
//                   width: 120,
//                   child: enteredGroup == 0
//                       ? CustomButton(
//                           onPressed: joinPressButton,
//                           color: primaryColor,
//                           text: isPage!
//                               ? getTextButtonPages(enteredGroup!)
//                               : getTextButtonGroup(
//                                   enteredGroup!,
//                                 ),
//                           textColor: Colors.white,
//                         )
//                       : CustomBorderButton(
//                           onPressed: joinPressButton,
//                           color: Colors.white,
//                           text: isPage!
//                               ? getTextButtonPages(enteredGroup!)
//                               : getTextButtonGroup(
//                                   enteredGroup!,
//                                 ),
//                         ),
//                 ),
//               )
//             ],
//           ),
//         ),
//         groupDetailsModel == null
//             ? SizedBox()
//             : groupDetailsModel!.isAdmin == 0
//                 ? SizedBox()
//                 : CustomAddPostWidget(
//                     onPressed: () {
//                       Get.to(() => AddPostToGroupView());
//                     },
//                   ),
//       ],
//     );
//   }
// }
