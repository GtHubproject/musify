import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/app/modules/bottomnavigationbar/controllers/bottomnavigationbar_controller.dart';
import 'package:musicplayer/app/modules/library/controllers/tracks_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FullSongplayerController extends GetxController {
  late TrackController trackController;
  late BottomnavigationbarController bottomController;
  late AudioPlayer audioPlayer;

  SongModel? get currentSong => bottomController.currentSong.value;


  bool _isShuffle = false;
  bool get isShuffle => _isShuffle;

  bool _isRepeat = false;
  bool get isRepeat => _isRepeat;

  @override
  void onInit() {
    super.onInit();
    trackController = Get.find<TrackController>();
    bottomController = Get.find<BottomnavigationbarController>();
    audioPlayer = bottomController.audioPlayer;
  }

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
    bottomController.playNextSong();
    update();
  }

   void toggleShuffle() {
    _isShuffle = !_isShuffle;
    update();
  }

  void toggleRepeat() {
    _isRepeat = !_isRepeat;
    update();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  void updateProgress() {
    update();
  }
}
