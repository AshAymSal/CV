import 'package:business/groups_pages/group_details/viewmodel/groupe_details_viewmodel.dart';
import 'package:business/widget/button/custom_button.dart';
import 'package:business/widget/custom_text.dart';
import 'package:business/widget/loading_stack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class GroupsDetailsMemberPending extends StatelessWidget {
  final int? groupId;

  GroupsDetailsMemberPending({this.groupId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer(
          builder: (BuildContext context,
              T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
            final viewModel = watch(groupDetailsViewModel(groupId!));

            print("hellop");
            return LoadingStack(
              isLoading: viewModel.isLoading,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          CustomText(
                            alignment: Alignment.centerRight,
                            text:
                                'الاعضاء قيد الانتظار: ${viewModel.pendingGroupMemberModel.length}',
                            fontSize: 22,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Consumer(
                    builder: (BuildContext context,
                        T Function<T>(ProviderBase<Object?, T>) watch,
                        Widget? child) {
                      final viewModel = watch(groupDetailsViewModel(groupId!));

                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Container(
                              child: Card(
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        radius: 30.0,
                                        backgroundImage: NetworkImage(viewModel
                                                    .pendingGroupMemberModel[
                                                        index]!
                                                    .userId!
                                                    .personalImage ==
                                                null
                                            ? 'https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg'
                                            : viewModel
                                                .pendingGroupMemberModel[index]!
                                                .userId!
                                                .personalImage!),
                                        backgroundColor: Colors.transparent,
                                      ),
                                      title: Text(viewModel
                                          .pendingGroupMemberModel[index]!
                                          .userId!
                                          .name!),
                                      subtitle: Text(viewModel
                                          .pendingGroupMemberModel[index]!
                                          .follow
                                          .toString()),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CustomButton(
                                            width: Get.width * 0.3,
                                            onPressed: () async {
                                              await viewModel.addPendingMemberToGroup(
                                                  id: viewModel
                                                      .pendingGroupMemberModel[
                                                          index]!
                                                      .id,
                                                  pendingGroup: viewModel
                                                          .pendingGroupMemberModel[
                                                      index]!);
                                            },
                                            text: 'أضافة',
                                            textColor: Colors.white,
                                          ),
                                          CustomButton(
                                            width: Get.width * 0.3,
                                            onPressed: () async {
                                              ///TODO :
                                              // await viewModel
                                              //     .deletePendingMemberFromGroup(
                                              //         viewModel
                                              //             .pendingGroupMemberModel[
                                              //                 index]
                                              //             .id,
                                              //         viewModel
                                              //                 .pendingGroupMemberModel[
                                              //             index]);
                                            },
                                            text: 'حذف',
                                            textColor: Colors.white,
                                            color: Colors.red,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: viewModel.pendingGroupMemberModel.length,
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
