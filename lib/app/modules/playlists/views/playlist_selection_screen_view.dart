import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        title: Text('Select Songs'),
      ),
      body: _buildSongList(),
     // bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildSongList() {
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
              return ListTile(
                title: Text(songs[index].title),
                subtitle: Text(songs[index].artist ?? "No Artist"),
                trailing: GestureDetector(
                  onTap: () {
             final selectedSong = songs[index];
              controller.addSongToPlaylist('YourPlaylistName', selectedSong);
  // Add any logic you need (e.g., show a message, update UI)
},

                  child: Icon(
                    
                        
                         Icons.add,
                  ),
                ),
                onTap: () {
                  // Handle song tap if needed
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