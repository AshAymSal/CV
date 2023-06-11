import 'package:business/core/network/end_points.dart';
import 'package:business/core/network/local/cache_helper.dart';
import 'package:business/groups_pages/choose_group/repo/choose_group_pages_repo.dart';
import 'package:business/groups_pages/group_details/model/group_details_data_model.dart';
import 'package:business/groups_pages/group_details/model/group_member_data_freezed/group_member_data_model.dart';
import 'package:business/groups_pages/group_details/repo/group_details_repo.dart';
import 'package:business/helper/constanc.dart';
import 'package:business/helper/functions.dart';
import 'package:business/media/model/media_model.dart';
import 'package:business/media/repos/media_repo.dart';
import 'package:business/post/model/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final changeTabBarIndex = StateProvider<int>((ref) => 0);

final groupDetailsViewModel = ChangeNotifierProvider.family(
    (ref, int groupId) => GroupDetailsViewModel(groupId: groupId));

class GroupDetailsViewModel extends ChangeNotifier {
  /// Constructor
  GroupDetailsViewModel({this.groupId}) {
    myToken = CacheHelper.getStringData(key: "myToken");
    getGroupDetails();
  }

  bool isLoading = false;
  bool isLoadingJoinButton = false;
  bool isLoadingGetGroupMember = false;
  bool isLoadingGetPhoto = false;
  int? groupId;
  int lastSelected = 0;
  String? myToken;

  // TO navigate to index list view of buttons

  GroupDetailsModel? groupDetailsData;
  PageOrGroupDetails? groupInfo = PageOrGroupDetails();
  List<PostModel>? postsList = [];
  List<MediaModel>? groupImage = [];

  /// group Members var
  List<GroupMember> adminsGroupMemberModel = [];
  List<GroupMember> acceptedGroupMemberModel = [];
  List<GroupMember?> pendingGroupMemberModel = [];

  Future getGroupDetails() async {
    isLoading = true;
    notifyListeners();
    groupDetailsData = await GroupDetailsRepo.getGroupPageDetails(
        token: myToken!, id: groupId!, isPage: false);
    groupInfo = groupDetailsData!.details;
    postsList = groupDetailsData!.groupPosts;
    isLoading = false;
    notifyListeners();
  }

  void getMembers() async {
    isLoadingGetGroupMember = true;
    notifyListeners();
    var list = await GroupDetailsRepo.getMembers(
      token: myToken!,
      groupId: groupId!,
      isPage: false,
    );
    try {
      adminsGroupMemberModel = list[0];
    } catch (e) {
      adminsGroupMemberModel = [];
    }
    try {
      acceptedGroupMemberModel = list[1];
    } catch (e) {
      print(e.toString());
      acceptedGroupMemberModel = [];
    }
  }

  void getPendingMembers() async {
    try {
      pendingGroupMemberModel = await GroupDetailsRepo.getPendingMember(
        token: myToken!,
        groupId: groupId!,
      );
    } catch (e) {
      print(e.toString());
      pendingGroupMemberModel = [];
    }
    isLoadingGetGroupMember = false;
    notifyListeners();
  }

  /// Get Photos
  void getPhotos() async {
    isLoadingGetPhoto = true;
    notifyListeners();
    groupImage = await MediaRepo.getPhoto(
      token: myToken!,
      groupId: groupId!,
      path: Get_Photo_Group,
    );
    isLoadingGetPhoto = false;
    notifyListeners();
  }

  Future addPendingMemberToGroup(
      {required int? id, required GroupMember pendingGroup}) async {
    String? state = await GroupDetailsRepo.acceptedGroupMember(
      token: myToken!,
      requestId: id!,
    );
    if (state == "request has updated successfully") {
      pendingGroup.copyWith(state: state);
      acceptedGroupMemberModel.add(pendingGroup);
      pendingGroupMemberModel.remove(pendingGroup);
      showToast(msg: state.toString(), color: colorBgToastSuccessBg);
    }
    isLoading = false;
    notifyListeners();
  }

  Future deletePendingMemberFromGroup(int? id, GroupMember pendingGroup) async {
    String? state = await GroupDetailsRepo.deleteGroupMember(
      token: myToken!,
      requestId: id!,
    );
    if (state == "request has delete successfully") {
      pendingGroupMemberModel.remove(pendingGroup);
      showToast(msg: state ?? '', color: colorBgToastSuccessBg);
    }
    isLoading = false;
    notifyListeners();
  }

  /// when button pressed
  void onPressButton({required int? groupId, required int entered}) {
    /// 0 = notEnter ,1 = Join, 2 = Pending
    /// Flag == 1 out From group
    /// Flag == 0 enter group
    if (entered == 0) {
      joinGroup(groupId: groupId, flag: 0);
    } else if (entered == 1) {
      joinGroup(groupId: groupId, flag: 1);
    } else if (entered == 2) {
      joinGroup(groupId: groupId, flag: 1);
    }
  }

  /// Send request to join the group
  void joinGroup({
    required int? groupId,
    required int flag,
  }) async {
    // 0 = notEnter ,1 = Joined, 2 = Pending
    isLoadingJoinButton = true;
    notifyListeners();
    int? flagResponse = await ChooseGroupRepo.joinGroupPage(
      token: myToken!,
      groupPageId: groupId!,
      flag: flag,
      isPage: false,
    );
    print(flagResponse);
    if (flagResponse == 0) {
      groupDetailsData!.register = 0;
    } else if (flagResponse == 1) {
      groupDetailsData!.register = 1;
    } else if (flagResponse == 2) {
      groupDetailsData!.register = 2;
    }
    isLoadingJoinButton = false;

    notifyListeners();
  }
}
