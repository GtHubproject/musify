import 'dart:async';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/app/modules/bottomnavigationbar/controllers/bottomnavigationbar_controller.dart';
import 'package:musicplayer/app/modules/bottomnavigationbar/views/fullplayer.dart';
import 'package:musicplayer/app/modules/library/controllers/tracks_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart';

class FullSongplayerController extends GetxController {
  late TrackController trackController;
  late BottomnavigationbarController bottomController;
  late AudioPlayer audioPlayer;

  RxBool _isShuffle = false.obs;
  bool get isShuffle => _isShuffle.value;

  RxBool _isRepeat = false.obs;
  bool get isRepeat => _isRepeat.value;

  Stream<PositionState> get positionState => _positionStateController.stream;
  late BehaviorSubject<PositionState> _positionStateController;

  SongModel? get currentSong => bottomController.currentSong.value;
  @override
  void onInit() {
    super.onInit();
    trackController = Get.find<TrackController>();
    bottomController = Get.find<BottomnavigationbarController>();
    audioPlayer = bottomController.audioPlayer;

    // Initialize the stream controller
    _positionStateController = BehaviorSubject<PositionState>();
    print("FullSongplayerController instance: $FullSongplayerController");
    print("TrackController instance: $trackController");
  }

//edit
  void seekTo(double seconds) {
    bottomController.audioPlayer.seek(Duration(seconds: seconds.toInt()));
  }

  void togglePlayPause() {
    if (bottomController.audioPlayer.playing) {
      print("Pausing song");
      bottomController.pauseSong();
    } else {
      print("Playing song");
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
      // bottomController.playNextSong();
      bottomController.audioPlayer.setShuffleModeEnabled(false);
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

  @override
  void onClose() {
    // Dispose of resources or perform cleanup when the controller is closed.
    // For example, if you have subscriptions, dispose them here.
    _positionStateController.close(); // Close the stream controller.

    // Dispose of any other resources or cleanup code here.

    super.onClose();
  }
}
