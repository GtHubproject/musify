import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class BottomnavigationbarController extends GetxController {
  var selectedIndex = 0.obs;
  late AudioPlayer audioPlayer;
  Rx<SongModel?> currentSong = Rx<SongModel?>(null);
  List<SongModel> _songs = [];

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    audioPlayer = AudioPlayer();

    // Listen for position changes  in the linear progressin indicator and update the UI
    audioPlayer.positionStream.listen((position) {
      update();
    });
    update();
  }

  // Add a method to play a song using the AudioPlayer
  Future<void> playSong(SongModel song) async {
    print('Playing song: ${song.title}');
    currentSong.value = song; // Update the current song
    await audioPlayer.setUrl(song.data);
    await audioPlayer.play();
    update();
    // Notify listeners
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

  // Add a method to set the list of songs for nexet palying
  void setSongs(List<SongModel> songs) {
    _songs = songs;
  }

  void playNextSong() {
    if (currentSong.value != null) {
      int currentIndex =
          _songs.indexWhere((song) => song.id == currentSong.value!.id);

      if (currentIndex != -1 && currentIndex < _songs.length - 1) {
        // If the current song is not the last song in the list
        playSong(_songs[currentIndex + 1]);
      } else {
        // If the current song is the last song, you can implement looping or any other logic
        // For example, you can go back to the first song:
        playSong(_songs.first);
      }
    }
  }
}
