import 'dart:io';

import 'package:business/core/network/end_points.dart';
import 'package:business/core/network/remote/api_caller.dart';
import 'package:business/media/model/music_model.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

class MusicRepo {
  static Future<List<MusicModel>?> getMusic({
    required String token,
  }) async {
    print(token);
    return (await ApiCaller.instance.requestPost(
          getAllMusicPath,
          (data) {
            return List<MusicModel>.from(
              data["myMusics"].map(
                (model) => MusicModel.fromJson(model),
              ),
            );
          },
          token: token,
          body: <String, dynamic>{
            "token": token,
          },
        )) ??
        [];
  }

  static Future<MusicModel?> addMusic({
    required String token,
    required File music,
    required File musicCover,
    required String name,
  }) async {
    return (await ApiCaller.instance.requestPost(
      addMusicPath,
      (data) {
        return MusicModel.fromJson(data);
      },
      token: token,
      body: <String, dynamic>{
        "token": token,
        "musicName": name,
        "musicCover": await MultipartFile.fromFile(
          musicCover.path,
          filename: basename(musicCover.path),
        ),
        "music": await MultipartFile.fromFile(
          music.path,
          filename: basename(music.path),
        ),
      },
    ));
  }

  static Future<MusicModel?> deleteMusic({
    required String token,
    required int id,
  }) async {
    return (await ApiCaller.instance.requestPost(
      deleteMusicPath,
      (data) {
        return MusicModel.fromJson(data);
      },
      token: token,
      body: <String, dynamic>{
        "token": token,
        "target_id": id,
      },
    ));
  }
}
