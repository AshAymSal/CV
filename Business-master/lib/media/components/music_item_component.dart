import 'package:business/helper/constanc.dart';
import 'package:business/media/model/music_model.dart';
import 'package:business/media/viewmodel/music_player_viewmodel.dart';
import 'package:business/widget/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MusicItemComponent extends ConsumerWidget {
  const MusicItemComponent({
    Key? key,
    required this.musicModel,
    required this.onPressDelete,
  }) : super(key: key);
  final Function onPressDelete;
  final MusicModel musicModel;

  @override
  Widget build(BuildContext context, watch) {
    final viewModelPlayer = watch(musicPlayerViewModel(musicModel));

    return Container(
      child: Card(
        elevation: 10,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  key: const Key('delete'),
                  onPressed: () => onPressDelete(),
                  iconSize: 20.0,
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                ),
                IconButton(
                  key: const Key('play_button'),
                  onPressed: () =>
                      viewModelPlayer.isPlaying ? null : viewModelPlayer.play(),
                  iconSize: 30.0,
                  icon: const Icon(Icons.play_arrow),
                  color: primaryColor,
                ),
                IconButton(
                  key: const Key('pause_button'),
                  onPressed:
                      viewModelPlayer.isPlaying ? viewModelPlayer.pause : null,
                  iconSize: 30.0,
                  icon: const Icon(Icons.pause),
                  color: primaryColor,
                ),
                IconButton(
                  key: const Key('stop_button'),
                  onPressed:
                      viewModelPlayer.isPlaying || viewModelPlayer.isPaused
                          ? viewModelPlayer.stop
                          : null,
                  iconSize: 30.0,
                  icon: const Icon(Icons.stop),
                  color: primaryColor,
                ),
                Expanded(
                  child: CustomText(
                    text: musicModel.name!,//Mina Removing musicId class 5/1/2022
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    musicModel.image!,//Mina Removing musicId class 5/1/2022
                    width: 60,
                    height: 60,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            viewModelPlayer.position == null
                ? SizedBox.shrink()
                : Text(
                    viewModelPlayer.position != null
                        ? '${viewModelPlayer.positionText} / ${viewModelPlayer.durationText}'
                        : viewModelPlayer.durationViewModel != null
                            ? viewModelPlayer.durationText
                            : '',
                    style: const TextStyle(fontSize: 24.0),
                  ),
          ],
        ),
      ),
    );
  }
}
