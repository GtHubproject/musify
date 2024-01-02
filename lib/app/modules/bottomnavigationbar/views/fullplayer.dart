import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
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
          children: [SizedBox(height:20),
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
            StreamBuilder(
              stream: fullSongplayerController.audioPlayer.positionStream,
              builder: (context, snapshot) {
                final positionState = snapshot.data;

                return ProgressBar(
                  progress: positionState ?? Duration.zero,
                  total:
                      Duration(milliseconds: controller.currentSong!.duration!),
                  progressBarColor: const Color.fromARGB(255, 219, 149, 144),
                  baseBarColor: Colors.black,
                  bufferedBarColor: Colors.white.withOpacity(0.24),
                  thumbColor: Color.fromARGB(255, 71, 51, 51),
                  barHeight: 3.0,
                  thumbRadius: 8.0,
                  onSeek: fullSongplayerController.audioPlayer.seek,
                );
              },
            ),
            SizedBox(height: 16),
            GetBuilder<FullSongplayerController>(builder: (context) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //   Obx( () =>
                  IconButton(
                    icon: Icon(Icons.shuffle),
                    color: controller.isShuffle ? Colors.amber : Colors.black,
                    onPressed: () {
                      controller.toggleShuffle();
                    },
                  ),
                  // ),
                  IconButton(
                    icon: Icon(
                      Icons.skip_previous, // Add the icon for Previous Song
                      color: Colors.black,
                    ),
                    onPressed: () {
                      fullSongplayerController.playPreviousSong();
                    },
                  ),
                 
                  Container(
                    width: 70.0, // Adjust the width and height as needed
                    height: 70.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 192, 128, 125),
                    ),
                    child: IconButton(
                      icon: Icon(
                        controller.audioPlayer.playing
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: controller.audioPlayer.playing
                            ? Color.fromARGB(255, 76, 26, 8)
                            : const Color.fromARGB(255, 79, 25, 21),
                             size: 32,
                      ),
                      onPressed: () {
                        print("Play/Pause button pressed");
                        controller.togglePlayPause();
                      },
                    ),
                  ),

                  //),

                  IconButton(
                    icon: Icon(
                      Icons.skip_next,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      controller.playNextSong();
                    },
                  ),
                 
                  IconButton(
                    icon: Icon(Icons.repeat),
                    color: controller.isRepeat ? Colors.amber : Colors.black,
                    onPressed: () {
                      controller.toggleRepeat();
                    },
                  ),
                  
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

class PositionState {
  const PositionState(
      {required this.position, required this.buffered, required this.total});
  final Duration position;
  final Duration buffered;
  final Duration total;
}
