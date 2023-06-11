// import 'package:business/groups_pages/group_details/view/pages/group_member.dart';
// import 'package:business/groups_pages/group_details/viewmodel/page_details_viewmodel.dart';
// import 'package:business/groups_pages/group_details/widget/group_details_about_page.dart';
// import 'package:business/groups_pages/group_details/widget/group_details_header_widget.dart';
// import 'package:business/helper/constanc.dart';
// import 'package:business/media/screens/media_list_view.dart';
// import 'package:business/post/screens/posts_list_screen.dart';
// import 'package:business/widget/button/custom_button.dart';
// import 'package:business/widget/loading_stack.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';
//
// /// TODO :
// /// MAKE REQUESTS ON MEMBER AS BUTTON
//
// class PageDetailsView extends StatefulWidget {
//   PageDetailsView({required this.pageId});
//
//   final int? pageId;
//
//   @override
//   _PageDetailsViewState createState() => _PageDetailsViewState(pageId: pageId);
// }
//
// class _PageDetailsViewState extends State<PageDetailsView>
//     with SingleTickerProviderStateMixin {
//   _PageDetailsViewState({required this.pageId});
//
//   late TabController _tabController;
//   int? pageId;
//
//   late ScrollController _scrollController;
//
//   @override
//   void initState() {
//     _scrollController = ScrollController();
//     _tabController = TabController(length: 4, vsync: this);
//     _tabController.index = 0;
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         extendBodyBehindAppBar: true,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0.0,
//           leading: IconButton(
//             color: Colors.black,
//             onPressed: () {
//               Get.back();
//             },
//             icon: Icon(
//               Icons.arrow_back_ios,
//             ),
//           ),
//         ),
//         body: Consumer(
//           builder: (BuildContext context,
//               T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
//             final viewModel = watch(pageDetailsViewModel(pageId ?? 92));
//             _tabController.addListener(() {
//               watch(changeTabBarIndexPages).state = _tabController.index;
//             });
//             return viewModel.pageDetailsData == null
//                 ? SizedBox()
//                 : LoadingStack(
//                     isLoading: viewModel.isLoading,
//                     child: NestedScrollView(
//                       controller: _scrollController,
//                       headerSliverBuilder: (context, value) {
//                         return [
//                           SliverToBoxAdapter(
//                             child: GroupDetailsHeaderWidget(
//                               enteredGroup: viewModel.pageDetailsData!.register,
//                               groupId: pageId!,
//                               joinPressButton: () {
//                                 viewModel.onPressButton(
//                                   entered: viewModel.pageDetailsData!.register!,
//                                   groupId: pageId!,
//                                 );
//                               },
//                               groupDetailsModel: viewModel.pageDetailsData,
//                               isLoading: viewModel.isLoadingJoinButton,
//                               isPage: true,
//                             ),
//                           )
//                         ];
//                       },
//                       body: Container(
//                         padding: EdgeInsets.only(top: 20, bottom: 20),
//                         color: Colors.white,
//                         child: Column(
//                           children: [
//                             TabBar(
//                               indicatorColor: Colors.transparent,
//                               automaticIndicatorColorAdjustment: true,
//                               controller: _tabController,
//                               isScrollable: true,
//                               labelPadding: EdgeInsets.all(5),
//                               tabs: [
//                                 CustomButton(
//                                   width: 150,
//                                   onPressed: null,
//                                   text: 'الرئيسية',
//                                   color:
//                                       watch(changeTabBarIndexPages).state == 0
//                                           ? primaryColor
//                                           : Colors.grey.shade300,
//                                   textColor:
//                                       watch(changeTabBarIndexPages).state == 0
//                                           ? Colors.white
//                                           : Colors.black,
//                                   padding: 0,
//                                 ),
//                                 CustomButton(
//                                   onPressed: null,
//                                   text: 'الأعضاء',
//                                   color:
//                                       watch(changeTabBarIndexPages).state == 1
//                                           ? primaryColor
//                                           : Colors.grey.shade300,
//                                   textColor:
//                                       watch(changeTabBarIndexPages).state == 1
//                                           ? Colors.white
//                                           : Colors.black,
//                                   width: 150,
//                                 ),
//                                 CustomButton(
//                                   onPressed: null,
//                                   text: 'عن المجموعة',
//                                   color:
//                                       watch(changeTabBarIndexPages).state == 2
//                                           ? primaryColor
//                                           : Colors.grey.shade300,
//                                   textColor:
//                                       watch(changeTabBarIndexPages).state == 2
//                                           ? Colors.white
//                                           : Colors.black,
//                                   width: 150,
//                                 ),
//                                 CustomButton(
//                                   onPressed: null,
//                                   text: 'الصور',
//                                   color:
//                                       watch(changeTabBarIndexPages).state == 3
//                                           ? primaryColor
//                                           : Colors.grey.shade300,
//                                   textColor:
//                                       watch(changeTabBarIndexPages).state == 3
//                                           ? Colors.white
//                                           : Colors.black,
//                                   width: 150,
//                                 ),
//                               ],
//                               onTap: (index) {
//                                 if (index == 1) {
//                                   if (viewModel.adminsGroupMemberModel.length ==
//                                           0 &&
//                                       viewModel.acceptedGroupMemberModel
//                                               .length ==
//                                           0) {
//                                     viewModel.getMembers();
//                                   }
//                                 }
//                                 if (index == 3) {
//                                   if (viewModel.groupImage == null) {
//                                     viewModel.getPhotos();
//                                   }
//                                 }
//                               },
//                             ),
//                             Expanded(
//                               child: Container(
//                                 child: TabBarView(
//                                   controller: _tabController,
//                                   children: [
//                                     PostsListScreen(
//                                       modelType: "group",
//                                       modelId: pageId,
//                                     ),
//                                     GroupsMemberWidget(
//                                       groupDetailsModel:
//                                           viewModel.pageDetailsData!,
//                                       isLoading:
//                                           viewModel.isLoadingGetGroupMember,
//                                       id: viewModel.groupId!,
//                                       adminsGroupMemberModel:
//                                           viewModel.adminsGroupMemberModel,
//                                       acceptedGroupMemberModel:
//                                           viewModel.acceptedGroupMemberModel,
//                                     ),
//                                     GroupsDetailsAboutPage(
//                                         pageOrGroupDetails:
//                                             viewModel.groupInfo),
//                                     LoadingStack(
//                                       isLoading: viewModel.isLoading,
//                                       child: MediaListView(
//                                         images: viewModel.groupImage,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//           },
//         ),
//       ),
//     );
//   }
// }
