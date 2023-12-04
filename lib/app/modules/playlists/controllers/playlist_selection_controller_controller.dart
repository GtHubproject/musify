import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:musicplayer/app/data/model/box.dart';
import 'package:musicplayer/app/data/model/song_model.dart';
import 'package:on_audio_query/on_audio_query.dart';




// class PlaylistSelectionController extends GetxController {
//   final musicBox = Hive.box<Music>('musicBox');

//   void addSongToPlaylist(String playlistName, SongModel song) {
//   if (musicBox.isOpen) {
//     // Check if the playlist exists, create if not
//     if (!musicBox.containsKey(playlistName)) {
//       musicBox.put(playlistName, Music(songs: [])); // Replace YourPlaylistModel with your actual playlist model
//     }

//     final music = musicBox.get(playlistName);
//     if (music != null) {
//       try {
//         music.songs.add(song);
//         musicBox.put(playlistName, music);
//         print('Song added to playlist: $playlistName');
//       } catch (e) {
//         print('Error adding song to playlist: $e');
//       }
//     } else {
//       print('Error: Playlist not found.');
//     }
//   } else {
//     print('Error: The musicBox is not open.');
//   }
// }



// } 



class PlaylistSelectionController extends GetxController {
  final musicBox = Hive.box<Music>('musicBox');

   // Add this function to add songs to the selected playlist
  // Add this function to add songs to the selected playlist
  Future<void> addSongsToPlaylist(String playlistName, List<SongModel> songs) async {
    // Retrieve the playlist from the box
    Music? playlistNullable = musicBox.get(playlistName);

    // Check if the playlist is null, if so, provide a default value
    Music playlist = playlistNullable ?? Music(songs: []);

    // Add songs to the playlist
    playlist.songs.addAll(songs);

    // Save the updated playlist back to the box
    await musicBox.put(playlistName, playlist);
  }
}
