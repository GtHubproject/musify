import 'package:get/get.dart';
import 'package:musicplayer/app/modules/library/controllers/tracks_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';


class AlbumSongsController extends GetxController {
  RxList<SongModel> songs = <SongModel>[].obs;
  final TrackController trackController;

  AlbumSongsController(this.trackController);

  void loadSongsByAlbum(String albumId) async {
    songs.clear();
    
    // Get all songs
    List<SongModel> allSongs = await trackController.querySongs();

    // Filter songs by album ID
    List<SongModel> albumSongs = allSongs
        .where((song) => song.albumId == albumId)
        .toList();

    songs.addAll(albumSongs);
  }
}
