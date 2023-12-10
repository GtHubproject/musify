import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class BottomnavigationbarController extends GetxController {
  var selectedIndex = 0.obs;
  late AudioPlayer audioPlayer;
  Rx<SongModel?> currentSong = Rx<SongModel?>(null);

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    audioPlayer = AudioPlayer();
    update();
  }

  // Add a method to play a song using the AudioPlayer
  Future<void> playSong(SongModel song) async {
    print('Playing song: ${song.title}');
    currentSong.value = song; // Update the current song
    await audioPlayer.setUrl(song.data);
    await audioPlayer.play();
    update(); // Notify listeners
  }

  // Add a method to pause the currently playing song
  Future<void> pauseSong() async {
    print('Pausing song');
    await audioPlayer.pause();
    update();
  }

  // Add a method to stop the currently playing song
  Future<void> stopSong() async {
    print('Stopping song');
    await audioPlayer.stop();
    currentSong.value = null;
    update();
  }

   void setCurrentSong(SongModel song) {
    currentSong.value = song;
    update(); // Notify listeners
  }
}
