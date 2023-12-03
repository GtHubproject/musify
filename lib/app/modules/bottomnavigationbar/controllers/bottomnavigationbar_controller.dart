import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

enum PlayerState { stopped, playing, paused }

class BottomnavigationbarController extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer();

  final RxBool isPlaying = false.obs;
  var selectedIndex = 0.obs;

  final isMiniPlayerVisible = false.obs;
  final Rx<SongModel?> currentSong = Rx<SongModel?>(null);


 PlayerState playerState = PlayerState.stopped;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  // Ensure proper initialization
  void initializeAudioPlayer(String song) {
    audioPlayer.setUrl(song);
  }

  // final currentSong = SongModel().obs;
  // final isPlaying = false.obs;

  void setMiniPlayerVisible(bool visible) {
    isMiniPlayerVisible.value = visible;
  }

  void updateMiniPlayerState(SongModel song, bool playing) {
    currentSong.value = song;
    isPlaying.value = playing;
  }



  void togglePlayPause() {
    // Check if audioPlayer is null
    if (audioPlayer == null) {
      print("AudioPlayer is null!");
      return;
    }
    isPlaying.value = !isPlaying.value;

     if (isPlaying.value) {
      print("Playing");
      // If playing, resume or start playing
      audioPlayer.play();
    } else {
      print("Pausing");
      // If paused, pause
      audioPlayer.pause();
    }}

  void playSong(SongModel song) {
    currentSong.value = song;
    isPlaying.value = true;

    // Stop any currently playing song
    audioPlayer.stop();

    // Play the selected song
    audioPlayer.setUrl(song.data).then((_) {
      audioPlayer.play();
    });
  }
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  // void increment() => count.value++;
}
