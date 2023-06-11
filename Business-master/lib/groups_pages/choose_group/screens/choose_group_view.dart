// import 'package:business/groups_pages/choose_group/viewmodel/choose_groupe_viewmodel.dart';
// import 'package:business/groups_pages/choose_group/widget/show_groups.dart';
// import 'package:business/groups_pages/group_details/view/group_details_view.dart';
// import 'package:business/groups_pages/group_details/viewmodel/groupe_details_viewmodel.dart';
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
// class ChooseGroupsView extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, watch) {
//     final viewModel = watch(chooseGroupViewModel);
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: customAppBarWithPagesAndGroup(
//           title: 'المجموعات',
//           onPress: () {
//             Get.to(() => CreateGroupView(
//                   isPage: false,
//                 ));
//           },
//         ) as PreferredSizeWidget?,
//         body: SafeArea(
//           child: LoadingStack(
//             isLoading: viewModel.isLoading,
//             child: viewModel.myGroupDataModel == null ||
//                     viewModel.allGroupDataModel == null
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
//                                     'مجموعاتى  (${viewModel.myGroupDataModel!.length})',
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
//                                     ' كل المجموعات  (${viewModel.allGroupDataModel!.length})',
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
//                                   groupsPagesDataModel:
//                                       viewModel.allGroupDataModel!,
//                                   onPressedEntered: (int index) {
//                                     viewModel.onPressButton(
//                                       groupsDataModel:
//                                           viewModel.allGroupDataModel![index],
//                                       index: index,
//                                     );
//                                   },
//                                   isPage: false,
//                                   navigateToDetails: (int index) {
//                                     watch(changeTabBarIndex).state = 0;
//                                     watch(modelPostIdProvider).state =
//                                         viewModel.allGroupDataModel![index].id!;
//                                     watch(modelPostTypeProvider).state =
//                                         "group";
//                                     Get.to(
//                                       () => GroupDetailsView(
//                                         groupId: viewModel
//                                             .allGroupDataModel![index].id,
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               )
//                             // my Group
//                             : Expanded(
//                                 child: Consumer(
//                                   builder: (BuildContext context,
//                                       T Function<T>(ProviderBase<Object?, T>)
//                                           watch,
//                                       Widget? child) {
//                                     final viewModel =
//                                         watch(chooseGroupViewModel);
//                                     return ShowGroups(
//                                       groupsPagesDataModel:
//                                           viewModel.myGroupDataModel!,
//                                       onPressedEntered: (int index) {
//                                         viewModel.onPressButton(
//                                           groupsDataModel: viewModel
//                                               .allGroupDataModel![index],
//                                           index: index,
//                                         );
//                                       },
//                                       isPage: false,
//                                       navigateToDetails: (int index) {
//                                         watch(changeTabBarIndex).state = 0;
//                                         watch(modelPostIdProvider).state =
//                                             viewModel
//                                                 .myGroupDataModel![index].id!;
//                                         watch(modelPostTypeProvider).state =
//                                             "group";
//                                         Get.to(
//                                           () => GroupDetailsView(
//                                             groupId: viewModel
//                                                 .myGroupDataModel![index].id,
//                                           ),
//                                         );
//                                       },
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
