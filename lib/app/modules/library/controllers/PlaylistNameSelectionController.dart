import 'package:get/get.dart';

import 'package:hive/hive.dart';
import 'package:musicplayer/app/data/model/song_model.dart';
import 'package:on_audio_query/on_audio_query.dart';
//
  //final musicBox = Hive.box<Music>('musicBox');
  // late SongModel selectedSong; // To store the selected song

  // @override
  // void onInit() {
  //   // Retrieve the selected song from the navigation arguments
  //   selectedSong = Get.arguments['selectedSong'];

  //   super.onInit();
  // }

  // // Get the list of playlists
  // List<String> get playlists => musicBox.keys.cast<String>().toList();

  // // Get the number of songs in a playlist
  // int numberOfSongsInPlaylist(String playlistName) {
  //   Music playlist = musicBox.get(playlistName) ?? Music(songs: []);
  //   return playlist.songs.length;
  // }

  // Function to add the selected song to a playlist
  // void addSongToPlaylist(String playlistName) {
  //   try {
  //     // Retrieve the playlist from the box
  //     Music playlist = musicBox.get(playlistName) ?? Music(songs: []);

  //     // Add the selected song to the playlist
  //     playlist.songs.add(selectedSong);

  //     // Save the updated playlist back to the box
  //     musicBox.put(playlistName, playlist);

  //     // Optionally, show a snackbar or toast to indicate success
  //     Get.snackbar("Song Added", "${selectedSong.title} added to $playlistName");

  //     // Close the bottom sheet
  //     Get.back();
  //   } catch (e) {
  //     print('Error adding song to playlist: $e');
  //   }
  // }
//}
class PlaylistNameSelectionController extends GetxController {
  final musicBox = Hive.box<Music>('musicBox');
  late SongModel selectedSong;

  @override
  void onInit() {
   // Retrieve the selected song from the navigation arguments
  selectedSong = Get.arguments?['selectedSong'] ?? SongModel({});
    super.onInit();
  }

  // Getter to retrieve the list of playlists
  List<String> get playlistNames {
    return musicBox.keys.cast<String>().toList();
  }

  // Function to add the selected song to the chosen playlist
  void addSongToPlaylist(String playlistName) {
    // Retrieve the playlist from the box
    Music? existingPlaylist = musicBox.get(playlistName);

    // Check if the playlist is null, if so, provide a default value
    Music updatedPlaylist = existingPlaylist ?? Music(songs: []);

    // Add the selected song to the playlist
    updatedPlaylist.songs.add(selectedSong);

    // Save the updated playlist back to the box
    musicBox.put(playlistName, updatedPlaylist);
  }
}