import 'package:get/get.dart';
import 'package:musicplayer/app/data/model/song_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistsController extends GetxController {

//  Rx<Playlist> selectedPlaylist = Playlist(playlistName: '', songPaths: []).obs;

//   // Method to set the selected playlist
//   void setSelectedPlaylist(Playlist playlist) {
//     selectedPlaylist.value = playlist;
//   }


    // Placeholder for the selected songs
  RxList<SongModel> selectedSongs = <SongModel>[].obs;

  // Method to get selected songs
  List<SongModel> getSelectedSongs() {
    return selectedSongs.toList();
  }
//  List<SongModel> selectedSongs = [];

//   void toggleSelectedSong(SongModel song) {
//     if (selectedSongs.contains(song)) {
//       selectedSongs.remove(song);
//     } else {
//       selectedSongs.add(song);
//     }

//     // Notify listeners about the change
//     update();
//   }

  //TODO: Implement PlaylistsController

  // final count = 0.obs;
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  // void increment() => count.value++;
}
