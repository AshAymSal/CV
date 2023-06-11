import 'package:business/core/network/local/cache_helper.dart';
import 'package:business/groups_pages/choose_group/model/all_group_pages_data_model.dart';
import 'package:business/groups_pages/choose_group/repo/choose_group_pages_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final choosePagesViewModel =
    ChangeNotifierProvider((ref) => ChoosePagesViewModel());

class ChoosePagesViewModel extends ChangeNotifier {
  /// Constructor
  ChoosePagesViewModel() {
    myToken = CacheHelper.getStringData(key: "myToken");
    print(myToken);
    getAllPages();
    getMyGroups();
  }

  bool isLoading = false;
  int buttonSelected = 0;
  String? myToken;

  List<GroupsPagesDataModel>? allPagesDataModel = [];
  List<GroupsPagesDataModel>? myPagesDataModel = [];

  chooseButton(int index) {
    buttonSelected = index;
    notifyListeners();
  }

  /// Get ALL Groups

  void getAllPages() async {
    try {
      isLoading = true;
      notifyListeners();
      final result = await ChooseGroupRepo.getAllGroupsPages(
        token: myToken!,
        pages: true,
      );
      allPagesDataModel = result[0];
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
        pages: true,
      );
      myPagesDataModel = result[0];

      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      isLoading = false;
      notifyListeners();
    }
  }

  /// when button pressed
  void onPressButton({
    required GroupsPagesDataModel groupsPagesDataModel,
    required int index,
  }) {
    print(groupsPagesDataModel.toJson());
    if (groupsPagesDataModel.entered == 0) {
      joinGroup(groupId: groupsPagesDataModel.id!, flag: 0, index: index);
    } else if (groupsPagesDataModel.entered == 1) {
      joinGroup(groupId: groupsPagesDataModel.id!, flag: 1, index: index);
    }
  }

  /// Send request to join the group
  void joinGroup({
    required int groupId,
    required int flag,
    required int index,
  }) async {
    int? flagResponse = await ChooseGroupRepo.joinGroupPage(
      token: myToken!,
      groupPageId: groupId,
      flag: flag,
      isPage: true,
    );
    print(flagResponse);
    if (flagResponse == 0) {
      allPagesDataModel![index].entered = 0;
      myPagesDataModel!.removeWhere(
        (element) => element.id == groupId,
      );
      myPagesDataModel!.removeWhere(
        (element) => element.id == groupId,
      );
    } else if (flagResponse == 1) {
      allPagesDataModel![index].entered = 1;
      myPagesDataModel!.add(allPagesDataModel![index]);
    }
    notifyListeners();
  }

  void setNewGroups(GroupsPagesDataModel groupsPagesDataModel) {
    allPagesDataModel!.add(groupsPagesDataModel);
    myPagesDataModel!.add(groupsPagesDataModel);
    notifyListeners();
  }
}
