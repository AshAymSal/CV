import 'package:business/widget/custom_appbar.dart';
import 'package:flutter/material.dart';

class SavedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBarWithLeading(
          title: 'العناصر المحفوظة',
        ) as PreferredSizeWidget?,
        body: CustomScrollView(
          slivers: [
            /// TODO
            // SliverList(
            //   delegate: SliverChildBuilderDelegate(
            //     (context, index) {
            //       final Post post = savedPosts[index];
            //
            //       /// todo
            //
            //       // return GroupPostContainer();
            //     },
            //     childCount: savedPosts.length,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
