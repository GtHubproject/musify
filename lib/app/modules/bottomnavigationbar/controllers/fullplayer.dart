import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/app/modules/bottomnavigationbar/controllers/bottomnavigationbar_controller.dart';
import 'package:musicplayer/app/modules/library/controllers/tracks_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FullSongplayerController extends GetxController {
  late TrackController trackController;
  late BottomnavigationbarController bottomController;
  late AudioPlayer audioPlayer;

  @override
  void onInit() {
    super.onInit();
    trackController = Get.find<TrackController>();
    bottomController = Get.find<BottomnavigationbarController>();
     audioPlayer = bottomController.audioPlayer; 
  }

   SongModel? get currentSong => bottomController.currentSong.value;


  void seekTo(double seconds) {
    bottomController.audioPlayer.seek(Duration(seconds: seconds.toInt()));
  }

  void togglePlayPause() {
    if (bottomController.audioPlayer.playing) {
      bottomController.pauseSong();
    } else {
      bottomController.audioPlayer.play();
    }
    update();
  }

  void playNextSong() {
    // Implement logic to play the next song
    // You may need to update the currentSong value accordingly
    // For example, you can get the next song from the list of songs.
    // Update the trackController's current song and play it.
    // Then, update the currentSong value in this controller.

    // Example:
    // SongModel nextSong = getNextSong();
    // trackController.setCurrentSong(nextSong);
    // bottomController.playSong(nextSong);
    // currentSong.value = nextSong;
    update();
  }



   String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
