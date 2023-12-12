import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musicplayer/app/data/model/song_model.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:musicplayer/app/modules/library/controllers/PlaylistNameSelectionController.dart';

class PlaylistNameSelectionView extends GetView<PlaylistNameSelectionController> {
  @override




  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Playlist'),
      ),
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
    );
  }
}



