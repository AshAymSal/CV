import 'package:business/core/network/end_points.dart';
import 'package:business/core/network/remote/api_caller.dart';
import 'package:business/groups_pages/choose_group/model/all_group_pages_data_model.dart';

class ChooseGroupRepo {
  static Future<List> getAllGroupsPages({
    required String token,
    required bool pages,
  }) async {
    return (await ApiCaller.instance.requestPost(
          pages ? allPagesPath : allGroupPath,
          (data) {
            return [
              List<GroupsPagesDataModel>.from(
                data[pages ? 'pages' : 'groups'].map(
                  (model) => GroupsPagesDataModel.fromJson(model),
                ),
              ),
              data["count"],
            ];
          },
          token: token,
          body: <String, dynamic>{
            "token": token,
          },
        )) ??
        [].cast();
  }

  static Future<List> getMyGroupsPages(
      {String? token, required bool pages}) async {
    return (await ApiCaller.instance.requestPost(
          pages ? myPagesPath : myGroupPath,
          (data) {
            return [
              List<GroupsPagesDataModel>.from(
                data[pages ? 'pages' : 'groups'].map(
                  (model) => GroupsPagesDataModel.fromJson(model),
                ),
              ),
              data["count"],
            ];
          },
          token: token,
          body: <String, dynamic>{
            "token": token,
          },
        )) ??
        [].cast();
  }

  static Future<int?> joinGroupPage({
    required String token,
    required int groupPageId,
    required int flag,
    required bool isPage,
  }) async {
    var map = <String, dynamic>{
      "token": token,
      "flag": flag,
    };

    if (!isPage) map.addAll({"group_id": groupPageId});
    if (isPage) map.addAll({"page_id": groupPageId});

    return await ApiCaller.instance.requestPost(
      isPage ? joinPage : joinGroup,
      (data) {
        return data['user']['enteredId'];
      },
      token: token,
      body: map,
    );
  }
}
