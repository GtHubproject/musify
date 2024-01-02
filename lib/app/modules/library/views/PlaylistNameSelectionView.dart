import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musicplayer/app/data/model/song_model.dart';

import 'package:musicplayer/app/modules/library/controllers/PlaylistNameSelectionController.dart';


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

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(tileColor: const Color.fromARGB(255, 211, 196, 142),textColor: Colors.black,
                title: Text(playlistName),
                onTap: () {
                  // When a playlist is tapped, add the selected song to it
                  controller.addSongToPlaylist(playlistName);
                  // Optionally, you can navigate back or perform other actions
                  Get.back();
                },
              ),
            );
          },
        );
      },
    );
  }
}
