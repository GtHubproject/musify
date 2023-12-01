import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:musicplayer/app/data/model/song_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeController extends GetxController {
  final musicBox = Hive.box<Music>('musicBox');

  void createPlaylist(String playlistName, List<SongModel> songs) {
  if (musicBox.isOpen) {
    final music = Music(songs: songs);
    musicBox.put(playlistName, music);
  } else {
    // Handle the case where the box is not open
    print('Error: The musicBox is not open.');
    // You might want to add more robust error handling based on your application's needs.
  }
}

  // Rest of your controller code...
}

