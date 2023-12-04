import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:musicplayer/app/data/model/song_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

// class PlaylistDisplayController extends GetxController {
//   final musicBox = Hive.box<Music>('musicBox');

//   Future<List<SongModel>> getSongsForPlaylist(String playlistName) async {
//     if (musicBox.containsKey(playlistName)) {
//       final music = musicBox.get(playlistName) as Music;
//       return music.songs;
//     } else {
//       _printError('Error: Playlist not found.');
//       _printAvailablePlaylists();
//       return [];
//     }
//   }

//   void _printError(String message) {
//     print(message);
//   }

//   void _printAvailablePlaylists() {
//     print('Available Playlists:');
//     musicBox.keys.forEach((key) {
//       print('- $key');
//     });
//   }
// }
class PlaylistDisplayController extends GetxController {
  final musicBox = Hive.box<Music>('musicBox');
  late String playlistName;

  @override
  void onInit() {
    // Retrieve the selected playlist name from the navigation arguments
    playlistName = Get.arguments['playlistName'];

    super.onInit();
  }

  // ... Existing code ...
}

