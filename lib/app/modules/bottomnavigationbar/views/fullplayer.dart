import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:musicplayer/app/modules/bottomnavigationbar/controllers/bottomnavigationbar_controller.dart';
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
        title: Text('Now Playing'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            QueryArtworkWidget(
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
            SizedBox(height: 16),
            Row( mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      SongModel currentSong = controller.currentSong!;
                      // Call the addToFavorites method from the TrackController
                      trackController.addToFavorites(currentSong);
                      // Notify the FavoritesController to trigger a rebuild
                      Get.find<FavouritesController>().update();
                    },
                    icon: Icon(Icons.favorite_border,color: const Color.fromARGB(255, 25, 24, 24),)),


 Obx(() =>
                Text(
                  controller.currentSong?.title ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    
                    fontSize: 18,
                  ),
                ),)

              ],
            ),

             Obx(() =>
            Text(
              controller.currentSong?.artist ?? 'Unknown Artist',
              style: TextStyle(fontSize: 16),
            ),),
            SizedBox(height: 16),
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                //Obx(() =>
                LinearProgressIndicator(
                  value:
                      (controller.audioPlayer.duration?.inMilliseconds ?? 0) > 0
                          ? (controller.audioPlayer.position.inMilliseconds /
                                  controller
                                      .audioPlayer.duration!.inMilliseconds)
                              .clamp(0.0, 1.0)
                          : 0.0,
                  minHeight: 8,
                  backgroundColor: const Color.fromARGB(255, 35, 34, 34),
                  valueColor: AlwaysStoppedAnimation<Color>(const Color.fromARGB(255, 202, 187, 140)),
                ),
                //),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.shuffle),
                   color: controller.isShuffle ? Colors.amber : Colors.black,
                  onPressed: () {
                     controller.toggleShuffle();
                  },
                ),
                IconButton(
                  icon: Icon(controller.audioPlayer.playing
                      ? Icons.pause
                      : Icons.play_arrow,
                       color: controller.audioPlayer.playing ? Color.fromARGB(255, 162, 144, 70) : const Color.fromARGB(255, 79, 25, 21),
                      ),
                  onPressed: () {
                    controller.togglePlayPause();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.skip_next,color: Colors.black,),
                  onPressed: () {
                    controller.playNextSong();
                    
                  },
                ),
                IconButton(
                  icon: Icon(Icons.repeat),
                   color: controller.isRepeat ? Colors.amber :Colors.black,
                  onPressed: () {
                      controller.toggleRepeat();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
