import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musicplayer/app/data/model/song_model.dart';
import 'package:musicplayer/app/modules/library/controllers/PlaylistNameSelectionController.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistNameSelectionView extends GetView<PlaylistNameSelectionController> {
  final PlaylistNameSelectionController controller = Get.find<PlaylistNameSelectionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Playlists'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: controller.playlists.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(controller.playlists[index].name),
                  subtitle: Text('${controller.playlists[index].numberOfSongs} songs'),
                  trailing: Checkbox(
                    value: controller.playlists[index].isSelected,
                    onChanged: (value) {
                      controller.playlists[index].isSelected = value ?? false;
                      controller.update();
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              // Get the selected song
              SongModel? selectedSong ;

             // Check if selectedSong is not null before proceeding
      if (selectedSong != null) {
  // Call the function to add the song to the selected playlists
  await controller.addSongToSelectedPlaylists(selectedSong);

  // Optionally, show a snackbar or toast to indicate success
  Get.snackbar("Song Added", "${selectedSong.title} added to selected playlists");
} else {
  // Handle the case where selectedSong is null
  print("Selected song is null");
}
            },
            child: Text("Add to Playlist"),
          ),
        ],
      ),
    );
  }
}

