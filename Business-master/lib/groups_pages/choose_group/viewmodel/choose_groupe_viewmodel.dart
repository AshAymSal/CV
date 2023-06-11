import 'package:business/core/network/local/cache_helper.dart';
import 'package:business/groups_pages/choose_group/model/all_group_pages_data_model.dart';
import 'package:business/groups_pages/choose_group/repo/choose_group_pages_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chooseGroupViewModel =
    ChangeNotifierProvider.autoDispose((ref) => ChooseGroupViewModel());

class ChooseGroupViewModel extends ChangeNotifier {
  /// Constructor
  ChooseGroupViewModel() {
    myToken = CacheHelper.getStringData(key: "myToken");
    getAllGroups();
    getMyGroups();
  }

  bool isLoading = false;
  String? myToken;
  List<GroupsPagesDataModel>? allGroupDataModel = [];
  List<GroupsPagesDataModel>? myGroupDataModel = [];

  int buttonSelected = 0;
  chooseButton(int index) {
    buttonSelected = index;
    notifyListeners();
  }

  /// Get ALL Groups

  void getAllGroups() async {
    try {
      isLoading = true;
      notifyListeners();
      final result = await ChooseGroupRepo.getAllGroupsPages(
          token: myToken!, pages: false);
      allGroupDataModel = result[0];
      notifyListeners();
    } catch (e) {
      print(e);
      isLoading = false;
      notifyListeners();
    }
  }

  /// Get My Groups
  void getMyGroups() async {
    try {
      final result = await ChooseGroupRepo.getMyGroupsPages(
        token: myToken,
        pages: false,
      );
      myGroupDataModel = result[0];

      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      isLoading = false;
      notifyListeners();
    }
  }

  /// when button pressed
  void onPressButton(
      {required GroupsPagesDataModel groupsDataModel, required int index}) {
    /// 0 = notEnter ,1 = Join, 2 = Pending
    /// Flag == 1 out From group
    /// Flag == 0 enter group
    if (groupsDataModel.entered == 0) {
      joinGroup(groupId: groupsDataModel.id, flag: 0, index: index);
    } else if (groupsDataModel.entered == 1) {
      joinGroup(groupId: groupsDataModel.id, flag: 1, index: index);
    } else if (groupsDataModel.entered == 2) {
      joinGroup(groupId: groupsDataModel.id, flag: 1, index: index);
    }
  }

  /// Send request to join the group
  void joinGroup({
    required int? groupId,
    required int flag,
    required int index,
  }) async {
    // 0 = notEnter ,1 = Joined, 2 = Pending
    int? flagResponse = await ChooseGroupRepo.joinGroupPage(
      token: myToken!,
      groupPageId: groupId!,
      flag: flag,
      isPage: false,
    );
    if (flagResponse == 0) {
      allGroupDataModel![index].entered = 0;
      myGroupDataModel!.removeWhere(
        (element) => element.id == myGroupDataModel![index].id,
      );
      notifyListeners();
    } else if (flagResponse == 1) {
      allGroupDataModel![index].entered = 1;
      myGroupDataModel!.add(allGroupDataModel![index]);
      notifyListeners();
    } else if (flagResponse == 2) {
      allGroupDataModel![index].entered = 2;
      notifyListeners();
    }
  }

  void setNewGroups(GroupsPagesDataModel groupsDataModel) {
    allGroupDataModel!.add(groupsDataModel);
    myGroupDataModel!.add(groupsDataModel);
    notifyListeners();
  }
}
