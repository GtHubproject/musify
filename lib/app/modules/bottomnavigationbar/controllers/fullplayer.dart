import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/app/modules/bottomnavigationbar/controllers/bottomnavigationbar_controller.dart';
import 'package:musicplayer/app/modules/library/controllers/tracks_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FullSongplayerController extends GetxController {
  late TrackController trackController;
  late BottomnavigationbarController bottomController;
  late AudioPlayer audioPlayer;

   RxBool _isShuffle = false.obs;
  bool get isShuffle => _isShuffle.value;

  RxBool _isRepeat = false.obs;
  bool get isRepeat => _isRepeat.value;

  SongModel? get currentSong => bottomController.currentSong.value;




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
//sleeek
  double _progressValue = 0.0;
  double get progressValue => _progressValue;
//sleek
  void setProgressValue(double value) {
    _progressValue = value;
    update();
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
  if (_isShuffle.value) {
      // Shuffle the song list and play the next shuffled song
      bottomController.shuffleSongs();
    } else if (_isRepeat.value) {
      // If repeat is enabled, play the current song again
      bottomController.playSong(currentSong!);
    } else {
      // Play the next song in order
      bottomController.playNextSong();
    }
    update();
  }

   void playPreviousSong() {
    if (_isShuffle.value) {
      // Shuffle the song list and play the previous shuffled song
      bottomController.shuffleSongs();
    } else if (_isRepeat.value) {
      // If repeat is enabled, play the current song again
      bottomController.playSong(currentSong!);
    } else {
      // Play the previous song in order
      bottomController.playPreviousSong();
    }
    update();
  }



  



  void toggleShuffle() {
  _isShuffle.value = !_isShuffle.value;
  bottomController.audioPlayer.setShuffleModeEnabled(_isShuffle.value);
  if (_isShuffle.value) {
    // If shuffling is enabled, play the first shuffled song
    bottomController.shuffleSongs();
  } else {
    // If shuffling is disabled, play the next song in order
    bottomController.playNextSong();
  }
  update();
}


 void toggleRepeat() {
  _isRepeat.value = !_isRepeat.value;
  if (_isRepeat.value) {
    // Set the loop mode to one to repeat the current song
    bottomController.audioPlayer.setLoopMode(LoopMode.one);
  } else {
    // Set the loop mode to none to play the next song in order
    bottomController.audioPlayer.setLoopMode(LoopMode.off);
  }
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
