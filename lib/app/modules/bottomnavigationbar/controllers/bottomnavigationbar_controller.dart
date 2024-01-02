import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
//import 'package:audioplayers/audioplayers.dart';

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

  void shuffleSongs() {
    if (_songs.isNotEmpty) {
      _songs.shuffle();
      update();
    }
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

 void playPreviousSong() {
    if (currentSong.value != null) {
      int currentIndex =
          _songs.indexWhere((song) => song.id == currentSong.value!.id);

      if (currentIndex > 0) {
        // If the current song is not the first song in the list
        playSong(_songs[currentIndex - 1]);
      } else {
        // If the current song is the first song, you can implement looping or any other logic
        // For example, you can go to the last song:
        playSong(_songs.last);
      }
    }
  }


   // Update this method to play the selected song from a list
  // Update this method to play the selected song from a list
  void playSongFromList(SongModel selectedSong, List<SongModel> songList) {
    setCurrentSong(selectedSong);

    // Find the index of the selected song in the provided list
    int currentIndex = songList.indexWhere((song) => song.id == selectedSong.id);

    // Ensure that the selected song is found in the list
    if (currentIndex != -1) {
      _songs = List.from(songList); // Copy the list to ensure independence

      // Play the selected song
      playSong(selectedSong);

    // Listen for changes in player state to detect when the song completes
      audioPlayer.playerStateStream.listen((PlayerState state) {
        if (state.processingState == ProcessingState.completed) {
          playNextSong();
        }
      });

      // If the selected song is not the last in the list, update the list
      if (currentIndex < _songs.length - 1) {
        _songs = _songs.sublist(currentIndex);
      } else {
        // If the selected song is the last, play the first song
        _songs = List.from(songList);
      }
    } else {
      // Handle the case when the selected song is not found in the list
      print('Selected song not found in the provided list.');
    }
  }


}
