import 'package:business/core/network/end_points.dart';
import 'package:business/core/network/local/cache_helper.dart';
import 'package:business/groups_pages/choose_group/repo/choose_group_pages_repo.dart';
import 'package:business/groups_pages/group_details/model/group_details_data_model.dart';
import 'package:business/groups_pages/group_details/model/group_member_data_freezed/group_member_data_model.dart';
import 'package:business/groups_pages/group_details/repo/group_details_repo.dart';
import 'package:business/media/model/media_model.dart';
import 'package:business/media/repos/media_repo.dart';
import 'package:business/post/model/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final changeTabBarIndexPages = StateProvider<int>((ref) => 0);

final pageDetailsViewModel = ChangeNotifierProvider.family(
    (ref, int groupId) => PageDetailsViewModel(groupId: groupId));

class PageDetailsViewModel extends ChangeNotifier {
  /// Constructor
  PageDetailsViewModel({this.groupId}) {
    myToken = CacheHelper.getStringData(key: "myToken");
    getPageDetails();
  }

  bool isLoading = false;
  bool isLoadingJoinButton = false;
  bool isLoadingGetGroupMember = false;
  bool isLoadingGetPhoto = false;
  int? groupId;
  int lastSelected = 0;
  String? myToken;
  TextEditingController? sharePostController = TextEditingController();

  // TO navigate to index list view of buttons

  GroupDetailsModel? pageDetailsData;
  PageOrGroupDetails? groupInfo = PageOrGroupDetails();
  List<PostModel>? postsList = [];
  List<MediaModel>? groupImage = [];

  /// group Members var
  List<GroupMember> adminsGroupMemberModel = [];
  List<GroupMember> acceptedGroupMemberModel = [];

  Future getPageDetails() async {
    isLoading = true;
    notifyListeners();
    pageDetailsData = await GroupDetailsRepo.getGroupPageDetails(
      token: myToken!,
      id: groupId!,
      isPage: true,
    );

    groupInfo = pageDetailsData!.details;
    postsList = pageDetailsData!.groupPosts;
    isLoading = false;
    notifyListeners();
  }

  void getMembers() async {
    isLoadingGetGroupMember = true;
    notifyListeners();
    var list = await GroupDetailsRepo.getMembers(
        token: myToken!, groupId: groupId!, isPage: true);
    try {
      adminsGroupMemberModel = list[0];
    } catch (e) {
      adminsGroupMemberModel = [];
    }
    try {
      acceptedGroupMemberModel = list[1];
    } catch (e) {
      acceptedGroupMemberModel = [];
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

  /// when button pressed
  void onPressButton({required int? groupId, required int entered}) {
    if (entered == 0) {
      joinGroup(groupId: groupId!, flag: 0);
    } else if (entered == 1) {
      joinGroup(groupId: groupId!, flag: 1);
    }
  }

  /// Send request to join the group
  void joinGroup({
    required int groupId,
    required int flag,
  }) async {
    isLoadingJoinButton = true;
    notifyListeners();

    int? flagResponse = await ChooseGroupRepo.joinGroupPage(
      token: myToken!,
      groupPageId: groupId,
      flag: flag,
      isPage: true,
    );

    if (flagResponse == 0) {
      // allPagesDataModel![index].entered = 0;
      // myPagesDataModel!.removeWhere(
      //       (element) => element.id == groupId,
      // );
      // myPagesDataModel!.removeWhere(
      //       (element) => element.id == groupId,
      // );
      pageDetailsData!.register = 0;
    } else if (flagResponse == 1) {
      // allPagesDataModel![index].entered = 1;
      // myPagesDataModel!.add(allPagesDataModel![index]);

      pageDetailsData!.register = 1;
    }

    isLoadingJoinButton = false;

    notifyListeners();
  }
}
