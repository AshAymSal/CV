import 'package:flutter/material.dart';

import 'media_list_view.dart';

class PhotosView extends StatelessWidget {
  const PhotosView({Key? key, required this.myProfile}) : super(key: key);
  final bool myProfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaListView(),
    );
  }
}
