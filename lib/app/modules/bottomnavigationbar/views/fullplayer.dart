import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:musicplayer/app/modules/bottomnavigationbar/controllers/fullplayer.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FullSongplayerView extends GetView<FullSongplayerController> {
  const FullSongplayerView({Key? key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final SongModel song = arguments['song'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Full Player'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // QueryArtworkWidget(
          //   controller: YourAudioQueryController(), // Replace with your actual controller
          //   id: song.id.toString(), // Use the selected song ID
          //   type: ArtworkType.AUDIO,
          // ),
          SizedBox(height: 16),

          // SleekCircularSlider(
          //   min: 0,
          //   max: song.duration?.toDouble() ?? 100,
          //   initialValue: 0,
          //   onChange: (double value) {
          //     // Handle slider value change
          //   },
          //   innerWidget: (double value) {
          //     return Center(
          //       child: Column(
          //         children: [
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text('0:00'), // Replace with actual starting time
          //               Text('${formatDuration(song.duration)}'), // Use a function to format duration
          //             ],
          //           ),
          //           SizedBox(height: 8),

          //           Text(
          //             song.title,
          //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          //           ),
          //           Text(
          //             song.artist ?? 'Unknown Artist',
          //             style: TextStyle(fontSize: 16),
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          // ),
          SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Existing code...
            ],
          ),
        ],
      ),
    );
  }

  String formatDuration(int? duration) {
    if (duration != null) {
      Duration durationObject = Duration(milliseconds: duration);
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String twoDigitMinutes = twoDigits(durationObject.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(durationObject.inSeconds.remainder(60));
      return "$twoDigitMinutes:$twoDigitSeconds";
    } else {
      return '';
    }
  }
}
