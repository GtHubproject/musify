import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:musicplayer/app/modules/library/controllers/PlaylistNameSelectionController.dart';

// class PlaylistNameSelectionView extends GetView<PlaylistNameSelectionController> {
//   @override

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Playlist'),
//       ),
// body: ListView.builder(
//   itemCount: controller.playlists.length,
//   itemBuilder: (context, index) {
//     String playlistName = controller.playlists[index];
//     int numberOfSongs = controller.numberOfSongsInPlaylist(playlistName);

//     return ListTile(
//       title: Text(playlistName),
//       subtitle: Text('$numberOfSongs songs'),
//       onTap: () {
//         // Add the selected song to the chosen playlist
//         controller.addSongToPlaylist(playlistName);
//       },
//     );
//   },
// ),
//     );
//   }
// }

class PlaylistNameSelectionView
    extends GetView<PlaylistNameSelectionController> {
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
    return GetBuilder<PlaylistNameSelectionController>(
      builder: (controller) {
        List<String> playlistNames = controller.playlistNames;

        return ListView.builder(
          itemCount: playlistNames.length,
          itemBuilder: (context, index) {
            String playlistName = playlistNames[index];

            return ListTile(
              title: Text(playlistName),
              trailing: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  // Call the function to add the selected song to the playlist
                  controller.addSongToPlaylist(playlistName);

                  // Optionally, show a snackbar or toast to indicate success
                  Get.snackbar("Song Added",
                      "${controller.selectedSong.title} added to $playlistName");
                },
              ),
            );
          },
        );
      },
    );
  }
}
