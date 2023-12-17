import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:musicplayer/app/data/model/box.dart';
import 'package:musicplayer/app/data/model/song_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistSelectionController extends GetxController {
  final musicBox = Hive.box<Music>('musicBox');

   // Add this function to add songs to the selected playlist
  // Add this function to add songs to the selected playlist
  Future<void> addSongsToPlaylist(String playlistName, List<SongModel> songs) async {
    // Retrieve the playlist from the box
    Music? playlistNullable = musicBox.get(playlistName);

    // Check if the playlist is null, if so, provide a default value
    Music playlist = playlistNullable ?? Music(songs: []);

    // Check for duplicates and add only non-duplicate songs
  for (var song in songs) {
    if (!playlist.songs.contains(song)) {
      playlist.songs.add(song);
    }
  }

    // Save the updated playlist back to the box
    await musicBox.put(playlistName, playlist);
  }
}
