import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:musicplayer/app/data/model/song_model.dart';
import 'package:musicplayer/app/modules/playlists/controllers/playlist_selection_controller_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistSelectionView extends GetView<PlaylistSelectionController> {
  final PlaylistSelectionController controller = PlaylistSelectionController();
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor:   Color.fromARGB(255, 63, 29, 29),
        title: Text('Select Songs'),
      ),
      body: _buildSongList(controller.musicBox),
      // bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildSongList(Box<Music> musicBox) {
    return FutureBuilder<List<SongModel>>(
      future: _audioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          List<SongModel> songs = snapshot.data!;
          return ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) {
              // Declare selectedSong here
              final SongModel selectedSong = songs[index];

              return ListTile(
                title: Text(
                  selectedSong.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                subtitle: Text(
                  selectedSong.artist ?? "No Artist",
                  style: TextStyle(
                      fontWeight: FontWeight.w400, color: Colors.black),
                ),
                trailing: GestureDetector(
                    onTap: () async {
                      // Get the selected playlist name from the navigation arguments
                      String playlistName = Get.arguments['playlistName'];

                      // Get the selected song
                      SongModel selectedSong = songs[index];

                      // Call the function to add the song to the playlist
                      await controller
                          .addSongsToPlaylist(playlistName, [selectedSong]);

                      // Optionally, show a snackbar or toast to indicate success
                      Get.snackbar("Song Added",
                          "${selectedSong.title} added to $playlistName",
                          backgroundColor: Color.fromARGB(255, 203, 203, 165));
                    },
                    child: Container(
                      width: 24.0, // Set the desired width (adjust as needed)
                      height: 24.0, // Set the desired height (adjust as needed)
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 195, 113,
                            81), // Set the background color to yellow
                        borderRadius: BorderRadius.circular(
                            4.0), // Set the border radius for rounded corners
                      ),
                      child: Icon(
                        Icons.add,
                        color: const Color.fromARGB(255, 250, 250,
                            250), // Optionally, set the color of the icon
                      ),
                    )),
                onTap: () {
                  // ... Existing code ...
                },
              );
            },
          );
        } else {
          return Center(child: Text("No tracks found!"));
        }
      },
    );
  }
}
