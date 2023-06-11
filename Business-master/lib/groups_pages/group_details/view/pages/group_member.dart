import 'package:business/groups_pages/group_details/model/group_details_data_model.dart';
import 'package:business/groups_pages/group_details/model/group_member_data_freezed/group_member_data_model.dart';
import 'package:business/groups_pages/group_details/widget/group_details_member_pending.dart';
import 'package:business/groups_pages/invite_friend/invite_friend.dart';
import 'package:business/widget/button/custom_button.dart';
import 'package:business/widget/custom_border_button.dart';
import 'package:business/widget/custom_text.dart';
import 'package:business/widget/loading_stack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

/// friendship
///   1 - guest
///   2 - cancel ( cancel request)
///   3 - pending (not accept )
///   4 - accepted
///
/// friendshipId

class GroupsMemberWidget extends ConsumerWidget {
  GroupsMemberWidget({
    required this.groupDetailsModel,
    required this.isLoading,
    required this.id,
    required this.adminsGroupMemberModel,
    this.acceptedGroupMemberModel,
  });

  final GroupDetailsModel groupDetailsModel;
  final bool isLoading;
  final int id;
  final List<GroupMember> adminsGroupMemberModel;

  final List<GroupMember>? acceptedGroupMemberModel;

  @override
  Widget build(BuildContext context, watch) {
    return LoadingStack(
      isLoading: isLoading,
      child: CustomScrollView(
        slivers: [
          ///  INVITE PEOPLE
          groupDetailsModel.isAdmin == 1
              ? PendingUser(
                  onPressPendingUser: () {
                    Get.to(
                      () => GroupsDetailsMemberPending(
                        groupId: id,
                      ),
                    );
                  },
                )
              : SliverToBoxAdapter(),

          ///  INVITE PEOPLE
          InvitePeople(),
          adminsGroupMemberModel.length == 0
              ? SliverToBoxAdapter()
              : SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        CustomText(
                          alignment: Alignment.centerRight,
                          text: 'المسئولين : ${adminsGroupMemberModel.length}',
                          fontSize: 22,
                        ),
                      ],
                    ),
                  ),
                ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(
                          adminsGroupMemberModel[index].userId!.personalImage ==
                                  null
                              ? 'https://i.pinimg.com/originals/82/64/7e/82647eca04687361c6d515f335d4c08a.jpg'
                              : adminsGroupMemberModel[index]
                                  .userId!
                                  .personalImage!,
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                      title: Text(adminsGroupMemberModel[index].userId!.name!),
                      subtitle:
                          Text(adminsGroupMemberModel[index].follow.toString()),
                      trailing: Container(
                        width: 120,
                        child:
                            adminsGroupMemberModel[index].friendship == "guest"
                                ? CustomBorderButton(
                                    onPressed: () {
                                      /// TODO : SEND REQUEST
                                      // setState(() {
                                      //   groupManager[index].isFriend =
                                      //       false;
                                      // });
                                    },
                                    color: Colors.white,
                                    text: 'متابعة',
                                  )
                                : adminsGroupMemberModel[index].friendship ==
                                        "pending"
                                    ? CustomBorderButton(
                                        onPressed: () {
                                          /// TODO : DELETE REQUEST
                                          // setState(() {
                                          //   groupManager[index].isFriend =
                                          //       false;
                                          // });
                                        },
                                        color: Colors.white,
                                        text: 'تم ارسال الطلب',
                                      )
                                    : CustomButton(
                                        onPressed: () {
                                          // setState(() {
                                          //   print(groupManager[index].isFriend);
                                          //   groupManager[index].isFriend = true;
                                          // });
                                        },
                                        text: ' الغاء  متابعة',
                                        textColor: Colors.white,
                                      ),
                      ),
                      onTap: () {
                        ///
                      },
                    ),
                  ),
                );
              },
              childCount: adminsGroupMemberModel.length,
            ),
          ),
          acceptedGroupMemberModel!.length == 0
              ? SliverToBoxAdapter()
              : SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        CustomText(
                          alignment: Alignment.centerRight,
                          text: 'الاعضاء : ${acceptedGroupMemberModel!.length}',
                          fontSize: 22,
                        ),
                      ],
                    ),
                  ),
                ),
          acceptedGroupMemberModel!.length == 0
              ? SliverToBoxAdapter()
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Container(
                        child: Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                  acceptedGroupMemberModel![index]
                                              .userId!
                                              .personalImage ==
                                          null
                                      ? 'https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg'
                                      : acceptedGroupMemberModel![index]
                                          .userId!
                                          .personalImage!),
                              backgroundColor: Colors.transparent,
                            ),
                            title: Text(
                                acceptedGroupMemberModel![index].userId!.name!),
                            subtitle: Text(acceptedGroupMemberModel![index]
                                .follow
                                .toString()),
                            trailing: Container(
                              width: 120,
                              // child: viewModel.acceptedGroupMemberModel[index].isFriend
                              //     ? CustomBorderButton(
                              //         onPress: () {
                              //           // setState(() {
                              //           //   friendData[index].isFriend = false;
                              //           // });
                              //         },
                              //         color: Colors.white,
                              //         text: 'متابعة',
                              //       )
                              //     : CustomButton(
                              //         onPress: () {
                              //           // setState(() {
                              //           //   print(friendData[index].isFriend);
                              //           //   friendData[index].isFriend = true;
                              //           // });
                              //         },
                              //         text: 'الغاء  متابعة',
                              //         textColor: Colors.white,
                              //       ),
                            ),
                            onTap: () {
                              // Get.to(() => PageDetailsView());
                            },
                          ),
                        ),
                      );
                    },
                    childCount: acceptedGroupMemberModel!.length,
                  ),
                )
        ],
      ),
    );
  }
}

class PendingUser extends StatelessWidget {
  const PendingUser({Key? key, this.onPressPendingUser}) : super(key: key);

  final Function? onPressPendingUser;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: 'الأعضاء قيد الانتظار',
              fontSize: 22,
            ),
            Container(
              width: 120,
              height: 50,
              child: CustomButton(
                onPressed: onPressPendingUser,
                text: 'إضافة',
                textColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class InvitePeople extends StatelessWidget {
  const InvitePeople({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: 'دعوة الاصدقاء',
              fontSize: 22,
            ),
            Container(
              width: 120,
              height: 50,
              child: CustomButton(
                onPressed: () {
                  Get.to(() => InviteFriend());
                },
                text: 'دعوة',
                textColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
