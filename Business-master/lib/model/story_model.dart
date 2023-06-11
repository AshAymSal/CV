import 'package:business/profile/model/profile_model.dart';

class Story {
  final ProfileModel user;
  final String imageUrl;
  final bool isViewed;

  const Story({
    required this.user,
    required this.imageUrl,
    this.isViewed = false,
  });
}
