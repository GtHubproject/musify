import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:musicplayer/app/modules/library/controllers/tracks_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtistSongsController extends GetxController {
  RxList<SongModel> songs = <SongModel>[].obs;
  final TrackController trackController;

  ArtistSongsController(this.trackController);

  void loadSongsByArtist(String artistName) async {
    songs.clear();
    
    // Get all songs
    List<SongModel> allSongs = await trackController.querySongs();

    // Filter songs by artist name
    List<SongModel> artistSongs = allSongs
        .where((song) => song.artist == artistName)
        .toList();

    songs.addAll(artistSongs);
  }
}

