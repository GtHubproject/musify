import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive/hive.dart';
import 'package:musicplayer/app/data/model/song_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistNameSelectionController extends GetxController {
  final musicBox = Hive.box<Music>('musicBox');
  RxList<PlaylistItem> playlists = <PlaylistItem>[].obs;

  @override
  void onInit() {
    // Fetch the existing playlists from the musicBox
    fetchPlaylists();
    super.onInit();
  }

  void fetchPlaylists() {
    playlists.clear();
    musicBox.keys.forEach((playlistName) {
      // Get the number of songs in each playlist
      int numberOfSongs = (musicBox.get(playlistName) as Music?)?.songs.length ?? 0;

      // Add the playlist to the list
      playlists.add(PlaylistItem(name: playlistName, numberOfSongs: numberOfSongs, isSelected: false));
    });
  }
  
  // Function to add a song to the selected playlists
  Future<void> addSongToSelectedPlaylists(SongModel selectedSong) async {
    List<String> selectedPlaylists = playlists.where((playlist) => playlist.isSelected).map((playlist) => playlist.name).toList();
    
    // Add the selected song to each selected playlist
    for (String playlistName in selectedPlaylists) {
      await addSongToPlaylist(playlistName, selectedSong);
    }
  }

  Future<void> addSongToPlaylist(String playlistName, SongModel selectedSong) async {
    // Retrieve the playlist from the box
    Music? playlistNullable = musicBox.get(playlistName);

    // Check if the playlist is null, if so, provide a default value
    Music playlist = playlistNullable ?? Music(songs: []);

    // Add the selected song to the playlist
    playlist.songs.add(selectedSong);

    // Save the updated playlist back to the box
    await musicBox.put(playlistName, playlist);
  }
}

class PlaylistItem {
  final String name;
  final int numberOfSongs;
  bool isSelected;

  PlaylistItem({
    required this.name,
    required this.numberOfSongs,
    this.isSelected = false,
  });
}
