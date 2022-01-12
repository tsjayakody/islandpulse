import 'package:flutter/material.dart';
import 'package:islandpulse/page_manager.dart';
import 'package:islandpulse/widgets/widgets.dart';

class IslandPulseMusicPlayer extends StatelessWidget {
  const IslandPulseMusicPlayer({
    Key? key,
    required this.pageManager,
  }) : super(key: key);

  final PageManager pageManager;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) =>
          pageManager.dragControl(details),
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          ValueListenableBuilder<String>(
              valueListenable: pageManager.currentSongTitleNotifier,
              builder: (_, value, __) {
                // * album name text widget
                return AlbumNameText(value: value);
              }),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 0),
            child: ValueListenableBuilder<String>(
                valueListenable: pageManager.currentSongArtistNotifier,
                builder: (_, value, __) {
                  // * song name text widget
                  return SongNameText(value: value);
                }),
          ),
          //* song play/pause button
          PlayPauseButton(pageManager: pageManager),
          //* song skip widget (back and forward album name)
          SongBackwardForwardButton(pageManager: pageManager),
        ],
      ),
    );
  }
}
