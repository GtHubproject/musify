import 'package:get/get.dart';
import 'package:musicplayer/app/data/model/box.dart';
import 'package:musicplayer/app/data/model/song_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

// class PlaylistSelectionController extends GetxController {
//   //TODO: Implement PlaylistSelectionControllerController

//   final count = 0.obs;
//   @override
//   void onInit() {
//     super.onInit();
//   }

//   @override
//   void onReady() {
//     super.onReady();
//   }

//   @override
//   void onClose() {
//     super.onClose();
//   }

//   void increment() => count.value++;
// }

//
//previous
//1

//2
// class PlaylistSelectionController extends GetxController {
//   final RxList<SongModel> _selectedSongs = <SongModel>[].obs;

//   bool isSelected(SongModel song) => _selectedSongs.contains(song);

//   void toggleSelected(SongModel song) {
//     if (_selectedSongs.contains(song)) {
//       _selectedSongs.remove(song);
//     } else {
//       _selectedSongs.add(song);
//     }
//   }

//   void addSelectedSongsToPlaylist(Playlist selectedPlaylist) {

//      Boxes.getPlaylist().addSongsToPlaylist(selectedPlaylist, _selectedSongs);
//     // Implement the logic to add selected songs to the playlist
//     // For example, you can get the currently selected playlist and add songs to it
//     // Use Boxes.getPlaylist().addSongsToPlaylist(selectedPlaylist, _selectedSongs);
//     // Don't forget to clear the selected songs list after adding
//     _selectedSongs.clear();
//   }
// }



class PlaylistSelectionController extends GetxController {
  // Assuming you have a playlist variable in your controller
  final RxList<SongModel> selectedSongs = <SongModel>[].obs;
  final RxList<SongModel> playlist = <SongModel>[].obs; // Replace with your actual playlist type

  // Function to toggle selection of a song
  void toggleSelected(SongModel song) {
    if (isSelected(song)) {
      selectedSongs.remove(song);
    } else {
      selectedSongs.add(song);
    }
  }

  // Function to check if a song is selected
  bool isSelected(SongModel song) {
    return selectedSongs.contains(song);
  }

  // Function to add selected songs to the playlist
  void addSelectedSongsToPlaylist() {
    // Here, you can add the selected songs to your playlist
    for (SongModel song in selectedSongs) {
      // Replace the following line with the actual logic to add the song to your playlist
      // For example, if your playlist is a list, you can do:
       playlist.add(song);

      // If your playlist has a specific method to add songs, replace the line accordingly
    }

    // Optionally, you can clear the selected songs after adding them to the playlist
    selectedSongs.clear();
  }
}
