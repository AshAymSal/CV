import 'package:flutter/cupertino.dart';

class PagesModel {
  String image, name, numberMember;
  bool isLiked;

  PagesModel({
    required this.image,
    required this.name,
    required this.numberMember,
    required this.isLiked,
  });
}

final List<PagesModel> pagesModels = [
  PagesModel(
    image:
        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg',
    name: 'بيع وشراء',
    numberMember: '3الاف عضو',
    isLiked: false,
  ),
  PagesModel(
    image:
        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg',
    name: 'بيع وشراء',
    numberMember: '3الاف عضو',
    isLiked: false,
  ),
  PagesModel(
    image:
        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg',
    name: 'بيع وشراء',
    numberMember: '3الاف عضو',
    isLiked: false,
  ),
];
