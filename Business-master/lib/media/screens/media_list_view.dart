import 'package:business/media/model/media_model.dart';
import 'package:business/widget/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MediaListView extends StatelessWidget {
  final List<MediaModel>? images;

  MediaListView({this.images});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        images != null
            ? images!.length == 0
                ? SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: CustomText(
                        alignment: Alignment.center,
                        text: 'لا يوجد صور',
                        fontSize: 22,
                      ),
                    ),
                  )
                : SliverStaggeredGrid.count(
                    crossAxisCount: 2,
                    staggeredTiles: List.generate(
                        images!.length, (index) => StaggeredTile.fit(1)),
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                    // padding: EdgeInsets.all(10),
                    children: List.generate(
                      images!.length,
                      (index) => ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(images![index].filename!),
                      ),
                    ),
                  )
            : SliverToBoxAdapter(),
      ],
    );
  }
}
