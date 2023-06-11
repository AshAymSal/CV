import 'package:flutter/cupertino.dart';

class ChatModel {
  String name, image, lastMessage, date, time;

  ChatModel({
    required this.name,
    required this.image,
    required this.lastMessage,
    required this.date,
    required this.time,
  });
}

final List<ChatModel> chattingModel = [
  ChatModel(
    name: 'محمد احمد',
    image: 'assets/images/person.png',
    lastMessage: 'انت : في خلال ثلاثه أيام او ربعه',
    date: '27 Nov',
    time: '12:20',
  ),
  ChatModel(
    name: 'يوسف الليثى',
    image: 'assets/images/person.png',
    lastMessage: 'انت : التسليم بكرة',
    date: '25 Nov',
    time: '5:10',
  ),
];
