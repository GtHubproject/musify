import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:musicplayer/app/modules/bottomnavigationbar/controllers/fullplayer.dart';
import 'package:musicplayer/app/modules/favourites/controllers/favourites_controller.dart';
import 'package:musicplayer/app/modules/library/controllers/tracks_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FullSongplayerView extends GetView<FullSongplayerController> {
  FullSongplayerView({Key? key}) : super(key: key);

  final FullSongplayerController fullSongplayerController =
      Get.put(FullSongplayerController());

  final TrackController trackController = Get.put(TrackController());

  double _progressValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 63, 29, 29),
        title: Text('Now Playing'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () => QueryArtworkWidget(
                controller: controller.trackController.audioQuery,
                id: (controller.currentSong?.id) ?? 0,
                type: ArtworkType.AUDIO,
                artworkHeight: 250,
                artworkWidth: 250,
                nullArtworkWidget: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(235, 131, 83, 76),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  width: 250,
                  height: 242,
                  child: Icon(
                    Icons.music_note,
                    size: 100,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      SongModel currentSong = controller.currentSong!;
                      // Call the addToFavorites method from the TrackController
                      trackController.addToFavorites(currentSong);
                      // Notify the FavoritesController to trigger a rebuild
                      Get.find<FavouritesController>().update();
                    },
                    icon: Icon(
                      Icons.favorite_border,
                      color: const Color.fromARGB(255, 25, 24, 24),
                    )),
                Obx(
                  () => Text(
                    controller.currentSong?.title ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
            Obx(
              () => Text(
                controller.currentSong?.artist ?? 'Unknown Artist',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 16),
            StreamBuilder<Duration?>(
              stream: controller.bottomController.audioPlayer.durationStream,
              builder: (context, snapshot) {
                final totalDuration =
                    snapshot.data?.inMilliseconds.toDouble() ?? 0.0;
                return StreamBuilder<Duration>(
                  stream:
                      controller.bottomController.audioPlayer.positionStream,
                  builder: (context, positionSnapshot) {
                    final position = positionSnapshot.data ?? Duration.zero;
                    double progressValue =
                        controller.bottomController.audioPlayer.playing
                            ? position.inMilliseconds / totalDuration
                            : controller.progressValue;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            //sleek
                            LinearProgressIndicator(
                              value: progressValue,
                              minHeight: 14,
                              backgroundColor:
                                  const Color.fromARGB(255, 35, 34, 34),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                const Color.fromARGB(255, 202, 187, 140),
                              ),
                            ),

                            //for moving circle
                            Positioned(
                              left: progressValue *
                                  MediaQuery.of(context).size.width,
                              child: GestureDetector(
                                // Your draggable widget (e.g., a small round widget)
                                child: Container(
                                  width: 8,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                onHorizontalDragUpdate: (details) {
                                  double dragPosition =
                                      details.globalPosition.dx;
                                  double dragPercentage = dragPosition /
                                      MediaQuery.of(context).size.width;
                                  double newProgressValue =
                                      dragPercentage.clamp(0.0, 1.0);
                                  int newPosition =
                                      (totalDuration * newProgressValue)
                                          .round();
                                  controller.seekTo(newPosition.toDouble());
                                  controller.setProgressValue(newProgressValue);
                                },
                              ),
                            ),

                            Positioned(
                              top: 0,
                              bottom: 0, // Adjust the position as needed
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    controller.formatDuration(position),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    controller.formatDuration(Duration(
                                        milliseconds: totalDuration.toInt())),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Obx(
                  () => IconButton(
                    icon: Icon(Icons.shuffle),
                    color: controller.isShuffle ? Colors.amber : Colors.black,
                    onPressed: () {
                      controller.toggleShuffle();
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.skip_previous, // Add the icon for Previous Song
                    color: Colors.black,
                  ),
                  onPressed: () {
                    fullSongplayerController.playPreviousSong();
                  },
                ),
                IconButton(
                  icon: Icon(
                    controller.audioPlayer.playing
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: controller.audioPlayer.playing
                        ? Color.fromARGB(255, 162, 144, 70)
                        : const Color.fromARGB(255, 79, 25, 21),
                  ),
                  onPressed: () {
                    controller.togglePlayPause();
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.skip_next,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    controller.playNextSong();
                  },
                ),
                Obx(
                  () => IconButton(
                    icon: Icon(Icons.repeat),
                    color: controller.isRepeat ? Colors.amber : Colors.black,
                    onPressed: () {
                      controller.toggleRepeat();
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
