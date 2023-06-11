import 'package:business/core/network/end_points.dart';
import 'package:business/core/network/remote/api_caller.dart';
import 'package:business/groups_pages/choose_group/model/all_group_pages_data_model.dart';
import 'package:business/groups_pages/create_group/model/create_group_model.dart';

class CreateGroupPageRepo {
  static Future<GroupsPagesDataModel?> createGroupPage(
      {required CreateGroupModel createGroupModel,
      required bool isPage}) async {
    return await ApiCaller.instance.requestPost(
      isPage ? createPagePath : createGroupPath,
      (data) {
        return GroupsPagesDataModel.fromJson(
          data[isPage ? 'page' : 'group'],
        );
      },
      token: createGroupModel.token,
      body: createGroupModel.toMap(),
    );
  }
}
