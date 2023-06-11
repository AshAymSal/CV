import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';

///initiated at the app start to listen to notifications..
class FirebaseNotifications {
  ////made to not every time restart app the notification is setted up again
  static bool _isSettedUp = false;

  FirebaseNotifications._();

  /// static final FirebaseNotifications pushService = FirebaseNotifications._();
  FirebaseMessaging? _firebaseMessaging;

  static final _instance = FirebaseNotifications._();

  static FirebaseNotifications get instance => _instance;

  String? userToken;

  ///Get [FirebaseMessaging] object
  Future<FirebaseMessaging> get pushNotification async {
    if (_firebaseMessaging != null) return _firebaseMessaging!;
    _firebaseMessaging = await init();
    return _firebaseMessaging!;
  }

  ///Request permission for push notification according ios or android phone
  init() async {
    print('Initializing firebase notifications...');
    final FirebaseMessaging _pushNotification = FirebaseMessaging.instance;
    await _pushNotification.requestPermission(
      sound: true,
      alert: true,
      badge: true,
    );
    return _pushNotification;
  }

  ///Update token for current user
  setupToken() async {
    await pushNotification;
    _firebaseMessaging?.getToken().then((token) {
      print('Device token = ' + token.toString());

      userToken = token.toString();
    });
  }

  List<OverlayEntry> _overlayEntries = [];
  final player = AudioPlayer();

  ///Set notification Sound and handle Configuration according status
  setUpListeners() async {
    await pushNotification;
    setupToken();
    String alarmAudioPath = "assets/sounds/default_notification_sound.mp3";

    ///For app notifications sound, while the app is opened

    if (_isSettedUp) return;

    FirebaseMessaging.onMessage.listen((event) {
      // await _handleNotification();
      // if (Platform.isIOS) {
      //   dynamic msg;
      //   msg = message['aps'];
      //   type = msg['alert']['type'];
      //   title = msg['alert']['title'];
      //   description = msg['alert']['body'];
      //   route = msg['alert']['route'];
      //   status = msg['alert']['status'] ?? "info";
      // } else {
      //   type = message['data']['type'];
      //   title = message['notification']['title'];
      //   description = message['notification']['body'];
      //   route = message['data']['route'];
      //   status = message['data']['status'] ?? "info";
      // }

      player.play(alarmAudioPath, isLocal: true);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      getEventMessage(event);
      //TODO: _operateMessage(message);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    _isSettedUp = true;
  }

  ///Action that is taken when pressing notification
  static _operateMessage(Map<String, dynamic> message) {
    if (Platform.isIOS) {
    } else {}
  }

  getEventMessage(RemoteMessage event) {
    print("getEventMessage pesa");
    print(event.data);
  }

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage event) async {
    getEventMessage(event);
  }
}
