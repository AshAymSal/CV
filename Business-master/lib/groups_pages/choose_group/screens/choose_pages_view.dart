// import 'package:business/groups_pages/choose_group/viewmodel/choose_pages_viewmodel.dart';
// import 'package:business/groups_pages/choose_group/widget/show_groups.dart';
// import 'package:business/groups_pages/group_details/view/page_details_view.dart';
// import 'package:business/groups_pages/group_details/viewmodel/page_details_viewmodel.dart';
// import 'package:business/helper/constanc.dart';
// import 'package:business/post/viewmodel/models_viewmodel.dart';
// import 'package:business/widget/button/custom_button.dart';
// import 'package:business/widget/custom_appbar.dart';
// import 'package:business/widget/loading_stack.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';
//
// import '../../create_group/view/create_group_view.dart';
//
// class ChoosePagesView extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, watch) {
//     final viewModel = watch(choosePagesViewModel);
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: customAppBarWithPagesAndGroup(
//           title: 'الصفحات',
//           onPress: () {
//             Get.to(() => CreateGroupView(isPage: true));
//           },
//         ) as PreferredSizeWidget?,
//         body: SafeArea(
//           child: LoadingStack(
//             isLoading: viewModel.isLoading,
//             child: viewModel.myPagesDataModel == null ||
//                     viewModel.allPagesDataModel == null
//                 ? SizedBox()
//                 : Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: CustomButton(
//                                 height: 60,
//                                 onPressed: () {
//                                   viewModel.chooseButton(1);
//                                 },
//                                 text:
//                                     'صفحاتي  (${viewModel.myPagesDataModel!.length})',
//                                 color: viewModel.buttonSelected == 1
//                                     ? primaryColor
//                                     : Colors.white,
//                                 textColor: viewModel.buttonSelected == 1
//                                     ? Colors.white
//                                     : primaryColor,
//                               ),
//                             ),
//                             Expanded(
//                               child: CustomButton(
//                                 height: 60,
//                                 onPressed: () {
//                                   viewModel.chooseButton(0);
//                                 },
//                                 text:
//                                     ' كل الصفحات  (${viewModel.allPagesDataModel!.length})',
//                                 color: viewModel.buttonSelected == 1
//                                     ? Colors.white
//                                     : primaryColor,
//                                 textColor: viewModel.buttonSelected == 1
//                                     ? primaryColor
//                                     : Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                         viewModel.buttonSelected == 0
//                             ? Expanded(
//                                 // all groups
//                                 child: ShowGroups(
//                                 groupsPagesDataModel:
//                                     viewModel.allPagesDataModel!,
//                                 onPressedEntered: (int index) {
//                                   viewModel.onPressButton(
//                                     index: index,
//                                     groupsPagesDataModel:
//                                         viewModel.allPagesDataModel![index],
//                                   );
//                                 },
//                                 isPage: true,
//                                 navigateToDetails: (int index) {
//                                   watch(changeTabBarIndexPages).state = 0;
//
//                                   watch(modelPostIdProvider).state =
//                                       viewModel.allPagesDataModel![index].id!;
//                                   watch(modelPostTypeProvider).state = "page";
//                                   Get.to(
//                                     () => PageDetailsView(
//                                       pageId: viewModel
//                                           .allPagesDataModel![index].id,
//                                     ),
//                                   );
//                                 },
//                               ))
//                             // my Group
//                             : Expanded(
//                                 child: ShowGroups(
//                                   groupsPagesDataModel:
//                                       viewModel.myPagesDataModel!,
//                                   onPressedEntered: (int index) {
//                                     viewModel.onPressButton(
//                                       index: index,
//                                       groupsPagesDataModel:
//                                           viewModel.myPagesDataModel![index],
//                                     );
//                                   },
//                                   isPage: true,
//                                   navigateToDetails: (int index) {
//                                     watch(changeTabBarIndexPages).state = 0;
//                                     watch(modelPostIdProvider).state =
//                                         viewModel.myPagesDataModel![index].id!;
//                                     watch(modelPostTypeProvider).state = "page";
//                                     Get.to(
//                                       () => PageDetailsView(
//                                         pageId: viewModel
//                                             .myPagesDataModel![index].id,
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                       ],
//                     ),
//                   ),
//           ),
//         ),
//       ),
//     );
//   }
// }
