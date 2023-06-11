import 'package:business/core/network/end_points.dart';
import 'package:business/core/network/remote/api_caller.dart';
import 'package:business/groups_pages/group_details/model/group_member_data_freezed/group_member_data_model.dart';
import 'package:business/post/model/post_model.dart';
import 'package:business/profile/model/profile_model.dart';
import 'package:business/services/models/all_services_model.dart';

class ProfileRepo {
  static Future<List> getProfileDetails({
    required String token,
    required int id,
  }) async {
    return (await ApiCaller.instance.requestPost(
          getProfileDetailsPath + "/$id",
          (data) {
            return [
              ProfileModel.fromJson(data["profile"]["data"]),
              List<PostModel>.from(
                data["profile"]['posts'].map(
                  (model) => PostModel.fromJson(model),
                ),
              ),
              List<ServicesModel>.from(
                data["profile"]['services'].map(
                  (model) => ServicesModel.fromJson(model),
                ),
              ),
            ];
          },
          token: token,
          body: <String, dynamic>{
            "token": token,
          },
        )) ??
        [];
  }

  static Future<List> getMembers({
    required String token,
    required int groupId,
    required bool isPage,
  }) async {
    return (await ApiCaller.instance.requestPost(
          isPage ? ShowPageMember : ShowGroupMember,
          (data) {
            return [
              List<GroupMember>.from(
                data[isPage ? 'page_members' : 'group_members']["admins"].map(
                  (model) => GroupMember.fromJson(model),
                ),
              ),
              List<GroupMember>.from(
                data[isPage ? 'page_members' : 'group_members']["accepted"].map(
                  (model) => GroupMember.fromJson(model),
                ),
              ),
            ];
          },
          token: token,
          body: <String, dynamic>{
            "token": token,
            "group_id": groupId,
          },
        )) ??
        [].cast();
  }

  static Future<List<GroupMember?>> getPendingMember({
    required String token,
    required int groupId,
  }) async {
    return await ApiCaller.instance.requestPost(
          showGroupMemberPending,
          (data) {
            return List<GroupMember>.from(
              data['group_members']["pending"].map(
                (model) => GroupMember.fromJson(model),
              ),
            );
          },
          token: token,
          body: <String, dynamic>{
            "token": token,
            "group_id": groupId,
          },
        ) ??
        [];
  }

  static Future acceptedGroupMember({
    required String token,
    required int requestId,
  }) async {
    return await ApiCaller.instance.requestPost(
      showGroupMemberAcceptedOrDeleted,
      (data) {
        return data["request"]["msg"];
      },
      token: token,
      body: <String, dynamic>{
        "token": token,
        "request_id": requestId,
        "state": 1,
      },
    );
  }

  static Future deleteGroupMember({
    required String token,
    required int requestId,
  }) async {
    return await ApiCaller.instance.requestPost(
      showGroupMemberAcceptedOrDeleted,
      (data) {
        return data["request"]["msg"];
      },
      token: token,
      body: <String, dynamic>{
        "token": token,
        "request_id": requestId,
        "state": 0,
      },
    );
  }
}
