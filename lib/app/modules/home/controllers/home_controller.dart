import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:musicplayer/app/data/model/song_model.dart';


class HomeController extends GetxController {
  final musicBox = Hive.box<Music>('musicBox');

  // Function to create a playlist
  Future<void> createPlaylist(String playlistName) async {
    // Check if the playlist already exists
    if (musicBox.containsKey(playlistName)) {
      // Show an error message or handle accordingly
      return;
    }

    // Create a new playlist with an empty list of songs
    final Music newPlaylist = Music(songs: []);
    
    // Put the playlist into the box with the playlistName as the key
    await musicBox.put(playlistName, newPlaylist);
  }
}
