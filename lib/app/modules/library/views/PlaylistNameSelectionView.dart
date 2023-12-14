import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musicplayer/app/data/model/song_model.dart';

import 'package:musicplayer/app/modules/library/controllers/PlaylistNameSelectionController.dart';



// class PlaylistNameSelectionView
//     extends GetView<PlaylistNameSelectionController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Playlist'),
//       ),
//       body: _buildPlaylistList(),
//     );
//   }

//   Widget _buildPlaylistList() {
//     return GetBuilder<PlaylistNameSelectionController>(
//       builder: (controller) {
//         List<String> playlistNames = controller.playlistNames;

//         return ListView.builder(
//           itemCount: playlistNames.length,
//           itemBuilder: (context, index) {
//             String playlistName = playlistNames[index];

//             return ListTile(
//               title: Text(playlistName),
//               trailing: IconButton(
//                 icon: Icon(Icons.add),
//                 onPressed: () {
//                   // Call the function to add the selected song to the playlist
//                   controller.addSongToPlaylist(playlistName);

//                   // Optionally, show a snackbar or toast to indicate success
//                   Get.snackbar("Song Added",
//                       "${controller.selectedSong.title} added to $playlistName");
//                 },
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
class PlaylistNameSelectionView extends GetView<PlaylistNameSelectionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Playlist'),
      ),
      body: _buildPlaylistList(),
    );
  }

  Widget _buildPlaylistList() {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Music>('musicBox').listenable(),
      builder: (context, musicBox, child) {
        if (musicBox.isEmpty) {
          return Center(
            child: Text("No playlists found!"),
          );
        }

        return ListView.builder(
          itemCount: musicBox.length,
          itemBuilder: (context, index) {
            String playlistName = musicBox.keyAt(index);

            return ListTile(
              title: Text(playlistName),
              onTap: () {
                // When a playlist is tapped, add the selected song to it
                controller.addSongToPlaylist(playlistName);
                // Optionally, you can navigate back or perform other actions
                Get.back();
              },
            );
          },
        );
      },
    );
  }
}
