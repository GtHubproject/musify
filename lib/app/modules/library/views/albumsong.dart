import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:musicplayer/app/modules/library/controllers/albumcontroller.dart';
import 'package:musicplayer/app/modules/library/controllers/tracks_controller.dart';

class AlbumSongsScreen extends GetView<AlbumSongsController> {
  final AlbumSongsController trackController =
      Get.put(AlbumSongsController(Get.find<TrackController>()));

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments?? {};
    final String albumName = args['albumName'] as String? ?? "";
    final String albumId = args['albumId'] as String? ?? "";

    // Load songs by album when the screen is built
    controller.loadSongsByAlbum(albumId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Songs in $albumName'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.songs.length,
          itemBuilder: (context, index) {
            var song = controller.songs[index];
            return ListTile(
              title: Text(song.title),
              subtitle: Text(song.artist ?? "No Artist"),
              // Add other necessary UI components
            );
          },
        ),
      ),
    );
  }
}
