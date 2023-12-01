import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/app/data/model/song_model.dart';
import 'package:musicplayer/app/modules/playlists/controllers/playlist_selection_controller_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

// class PlaylistSelectionView extends GetView {
// //final PlaylistSelectionController controller = Get.find();

//    final OnAudioQuery _audioQuery = OnAudioQuery(); // Declare _audioQuery here
//   List<SongModel> _selectedSongs = [];

//   PlaylistSelectionView({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Songs to Playlist'),
//         centerTitle: true,
//       ),
//     body: _buildSongList(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Handle the "Done" button click
//           _onDoneButtonPressed();
//         },
//         child: Icon(Icons.done),
//       ),
//     );
//   }

//   Widget _buildSongList() {
//     return FutureBuilder<List<SongModel>>(
//       // Replace with your logic to fetch songs
//       future: _audioQuery.querySongs(
//         sortType: null,
//         orderType: OrderType.ASC_OR_SMALLER,
//         uriType: UriType.EXTERNAL,
//         ignoreCase: true,
//       ),
//       builder: (context, snapshot) {
//         if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//           List<SongModel> songs = snapshot.data!;
//           return ListView.builder(
//             itemCount: songs.length,
//             itemBuilder: (context, index) {
//               SongModel song = songs[index];
//               bool isSelected = _selectedSongs.contains(song);

//               return Expanded(
//                 child: ListTile(
//                   title: Text(song.title),
//                   subtitle: Text(song.artist ?? "No Artist"),
//                   leading: QueryArtworkWidget(
//                     controller: _audioQuery,
//                     id: song.id,
//                     type: ArtworkType.AUDIO,
//                   ),
//                   trailing: 

//                     Checkbox(
//                         value:  _selectedSongs.contains(song),
//                         onChanged: (value) {
//                           controller.toggleSelectedSong(song);
//                         }
//                         // onChanged: (value) {
//                         // setState(() {
//                         //   if (value != null) {
//                         //     if (value) {
//                         //       _selectedSongs.add(song);
//                         //     } else {
//                         //       _selectedSongs.remove(song);
//                         //     }
//                         //   }
//                         // });
//                         //},
//                         ),
                        
//                 )
//               );
//             },
//           );
//         } else {
//           return Center(child: Text("No tracks found!"));
//         }
//       },
//     );
//   }

//   void _onDoneButtonPressed() {
//     // Handle the "Done" button press, you can use _selectedSongs
//     // for the selected songs and perform the necessary logic.
//     // For example, you can add these songs to the selected playlist.
//     Get.back(); // Close the PlaylistSelectionScreen
//   }

  
// }

class PlaylistSelectionView extends GetView <PlaylistSelectionController>{
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Songs'),
      ),
      body: _buildSongList(),
      bottomNavigationBar: _buildBottomNavigationBar(),
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
                trailing: Obx(
                  () => controller.isSelected(songs[index])
                      ? Icon(Icons.check_circle, color: Colors.green)
                      : Icon(Icons.radio_button_unchecked),
                ),
                onTap: () {
                  controller.toggleSelected(songs[index]);
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

  Widget _buildBottomNavigationBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
        controller.addSelectedSongsToPlaylist();
          Get.back(); // Clos
        },
        child: Text('OK'),
      ),
    );
  }
}
