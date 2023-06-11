import 'package:business/media/screens/music_view.dart';
import 'package:business/media/screens/photos_view.dart';
import 'package:business/profile/view/hobbies_view.dart';
import 'package:business/profile/view/inspirations_view.dart';
import 'package:business/profile/view/sports_view.dart';
import 'package:get/get.dart';

class ActivityModel {
  final String? image, title;

  final int? index;
  final Function(bool? myProfile) onPressed;

  ActivityModel({
    required this.image,
    required this.title,
    required this.index,
    required this.onPressed,
  });
}

final List<ActivityModel> activityListView = [
  ActivityModel(
    image: 'assets/images/personView/music.png',
    title: 'موسيقى',
    index: 0,
    onPressed: (myProfile) {
      Get.to(() => MusicView(myProfile: myProfile!));
    },
  ),
  ActivityModel(
    image: 'assets/images/personView/video.png',
    title: 'فيديو',
    index: 1,
    onPressed: (myProfile) {
      Get.to(() => MusicView(myProfile: myProfile!));
    },
  ),
  ActivityModel(
    image: 'assets/images/personView/picture.png',
    title: 'صور',
    index: 2,
    onPressed: (myProfile) {
      Get.to(() => PhotosView(myProfile: myProfile!));
    },
  ),
  ActivityModel(
    image: 'assets/images/personView/sport.png',
    title: 'الرياضة',
    index: 3,
    onPressed: (myProfile) {
      Get.to(() => SportsView(myProfile: myProfile!));
    },
  ),
  ActivityModel(
    image: 'assets/images/personView/love_people.png',
    title: 'ملهمين',
    index: 4,
    onPressed: (myProfile) {
      Get.to(() => InspirationsView(myProfile: myProfile!));
    },
  ),
  ActivityModel(
    image: 'assets/images/personView/hopes.png',
    title: 'الهوايات',
    index: 4,
    onPressed: (myProfile) {
      Get.to(() => HobbiesView(myProfile: myProfile!));
    },
  ),
];
