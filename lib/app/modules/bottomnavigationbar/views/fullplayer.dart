import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:musicplayer/app/modules/bottomnavigationbar/controllers/bottomnavigationbar_controller.dart';
import 'package:musicplayer/app/modules/bottomnavigationbar/controllers/fullplayer.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class FullSongplayerView extends GetView<FullSongplayerController> {
  const FullSongplayerView({Key? key}) : super(key: key);

  

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
            ),

            SizedBox(height: 16),

            Text(
              controller.currentSong?.title ?? '',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            Text(
              controller.currentSong?.artist ?? 'Unknown Artist',
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 16),

Stack(
  alignment: Alignment.centerLeft,
  children: [
    // Linear Progress Indicator
    LinearProgressIndicator(
      value: (controller.audioPlayer.position.inSeconds.toDouble() /
          (controller.currentSong?.duration?.toDouble() ?? 1.0)), // Ensure non-zero denominator
      valueColor: AlwaysStoppedAnimation<Color>(
        Color.fromARGB(255, 213, 199, 199),
      ),
      backgroundColor: Colors.grey,
    ),

    // Dragged portion indicator
    AnimatedPositioned(
      left: (controller.audioPlayer.position.inSeconds.toDouble() /
              (controller.currentSong?.duration?.toDouble() ?? 1.0)) *
          MediaQuery.of(context).size.width, // Calculate left position based on progress
      duration: Duration(milliseconds: 500), // Adjust the duration of the animation
      child: Container(
        width: 5, // Adjust the width of the circular indicator
        height: 10, // Adjust the height of the circular indicator
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color.fromARGB(255, 92, 244, 54), // Change the color of the circular indicator
        ),
      ),
    ),

    // Time Display Row
    Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "00:00", // Replace with the left time value
              style: TextStyle(color: const Color.fromARGB(255, 16, 6, 6)),
            ),
            Text(
              // Format the duration based on the current song's position
             controller.formatDuration(controller.audioPlayer.position),
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    ),
  ],
),




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
