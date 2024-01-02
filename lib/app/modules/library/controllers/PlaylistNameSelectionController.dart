import 'package:get/get.dart';

import 'package:hive/hive.dart';
import 'package:musicplayer/app/data/model/song_model.dart';
import 'package:musicplayer/app/modules/library/controllers/tracks_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistNameSelectionController extends GetxController {
  final TrackController trackController = Get.find();

  // Assuming you have a list of available playlists
  List<String> playlists = ['Playlist1', 'Playlist2', 'Playlist3'];

  // Method to add the selected song to the chosen playlist
  void addSongToPlaylist(String playlistName) {
    // Get the selected song
    SongModel? selectedSong = trackController.getSelectedSong();

    if (selectedSong != null) {
      // Find the playlist in Hive
      final Music playlist =
          Hive.box<Music>('musicBox').get(playlistName, defaultValue: Music(songs: []))!;

      // Add the selected song to the playlist
      playlist.songs.add(selectedSong);

      // Save the updated playlist back to Hive
      Hive.box<Music>('musicBox').put(playlistName, playlist);

      // Notify the UI to update if needed
      trackController.update();
    }
  }
}
