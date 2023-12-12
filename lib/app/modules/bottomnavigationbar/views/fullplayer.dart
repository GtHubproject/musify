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

   final FullSongplayerController fullSongplayerController = Get.put(FullSongplayerController());

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
                  borderRadius: BorderRadius.circular(10.0),),
                   width: 250,
                    height: 242,
                  
                    child: Icon(Icons.music_note,
                    size: 100,
                    ),
                  ),
            ),

            SizedBox(height: 16),

            Row(
              children: [
                IconButton(onPressed:(){
                  SongModel currentSong = controller.currentSong!;
    // Call the addToFavorites method from the TrackController
    trackController.addToFavorites(currentSong);
    // Notify the FavoritesController to trigger a rebuild
    Get.find<FavouritesController>().update();
                }, icon:Icon(Icons.favorite)),
                Text(
                  controller.currentSong?.title ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),

            Text(
              controller.currentSong?.artist ?? 'Unknown Artist',
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 16),

           Stack(
  alignment: Alignment.centerLeft,
  children: [
    LinearProgressIndicator(
      value: (controller.audioPlayer.duration?.inMilliseconds ?? 0) > 0
          ? (controller.audioPlayer.position.inMilliseconds /
                  controller.audioPlayer.duration!.inMilliseconds)
          .clamp(0.0, 1.0):0.0,
      minHeight: 8,
      backgroundColor: Colors.grey,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
    ),
  ],
),


// Stack(

//   alignment: Alignment.centerLeft,
//   children: [
//     //progression bar
//   ],
// ),




            // SleekCircularSlider(
            //   min: 0,
            //   max: controller.currentSong?.duration?.toDouble() ?? 0.0,
            //   initialValue:
            //       controller.audioPlayer.position.inSeconds.toDouble(),
            //   onChangeEnd: (double value) {
            //     controller.seekTo(value);
            //   },
            //   innerWidget: (double value) {
            //     return Center(
            //       child: Text(
            //         '${(value / 60).floor()}:${(value % 60).floor()}',
            //         style: TextStyle(fontSize: 16),
            //       ),
            //     );
            //   },
            // ),

            SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.shuffle),
                  onPressed: () {
                    // Implement shuffle functionality here
                  },
                ),
                IconButton(
                  icon: Icon(controller.audioPlayer.playing
                      ? Icons.pause
                      : Icons.play_arrow),
                  onPressed: () {
                    controller.togglePlayPause();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  onPressed: () {
                    controller.playNextSong();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.repeat),
                  onPressed: () {
                    // Implement repeat functionality here
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
