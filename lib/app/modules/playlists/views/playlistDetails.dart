import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
//import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musicplayer/app/data/model/box.dart';
import 'package:musicplayer/app/data/model/song_model.dart';
import 'package:musicplayer/app/modules/playlists/widgets/renameDialog.dart';
import 'package:musicplayer/app/modules/playlists/widgets/showDeleteDialog.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../controllers/playlists_controller.dart';

import 'package:musicplayer/app/data/model/songmodel.dart' as MyAppSongModel;

// class PlaylistDisplayView extends GetView<PlaylistDisplayController> {
//   PlaylistDisplayView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//       return Scaffold(
//         appBar: AppBar(
//         title: Text('Detailed Playlist'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               Get.toNamed('/selectplaylist');
//             },
//           ),
//           PopupMenuButton(
//             icon: Icon(Icons.more_vert),
//             itemBuilder: (BuildContext context) {
//               return <PopupMenuEntry>[
//                 PopupMenuItem(
//                   child: ListTile(
//                     leading: Icon(Icons.edit),
//                     title: Text('Rename'),
//                   ),
//                   value: 'rename',
//                 ),
//                 PopupMenuItem(
//                   child: ListTile(
//                     leading: Icon(Icons.delete),
//                     title: Text('Delete'),
//                   ),
//                   value: 'delete',
//                 ),
//               ];
//             },
//             onSelected: (value) {
//               if (value == 'rename') {
//                 showRenameDialog(context);
//               } else if (value == 'delete') {
//                 showDeleteDialog(context);
//               }
//             },
//           ),
//         ],
//       ),
//       body:FutureBuilder<List<SongModel>>(
//   future: controller.getSongsForPlaylist('YourPlaylistName'),
//   builder: (context, snapshot) {
//     if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//       List<SongModel> songs = snapshot.data!;
//       return ListView.builder(
//         itemCount: songs.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(songs[index].title),
//             subtitle: Text(songs[index].artist ?? "No Artist"),
//             // Add any other UI elements you need
//           );
//         },
//       );
//     } else {
//       return Center(child: Text("No songs found in the playlist!"));
//     }
//   },
// ),

//     );
//   }

// }

class PlaylistDisplayView extends GetView<PlaylistDisplayController> {
  PlaylistDisplayView({Key? key}) : super(key: key);
  final PlaylistDisplayController controller = Get.find<PlaylistDisplayController>();
  @override
  Widget build(BuildContext context) {
   // Handle null case by providing a default playlistName if it's null
    String playlistName = controller.playlistName ?? '';
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Detailed Playlist: ${controller.playlistName}'),
      // ),

      appBar: AppBar(
        title: Text(playlistName),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.toNamed('/selectplaylist' , arguments: {'playlistName': controller.playlistName});
            },
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry>[
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Rename'),
                  ),
                  value: 'rename',
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Delete'),
                  ),
                  value: 'delete',
                ),
              ];
            },
            onSelected: (value) {
              if (value == 'rename') {
                showRenameDialog(context);
              } else if (value == 'delete') {
                showDeleteDialog(context);
              }
            },
          ),
        ],
      ),
      body: _buildSongList(),
    );
  }
 Widget _buildSongList() {
    return ValueListenableBuilder(
      valueListenable: controller.musicBox.listenable(),
      builder: (context, musicBox, child) {
        // Retrieve the selected playlist from the box
      Music playlist = musicBox.get(controller.playlistName) ?? Music(songs: []);


        return ListView.builder(
          itemCount: playlist.songs.length,
          itemBuilder: (context, index) {
            SongModel song = playlist.songs[index];

            return ListTile(
              title: Text(song.title),
              subtitle: Text(song.artist ?? "No Artist"),
              // Add more song details or onTap functionality as needed
            );
          },
        );
      },
    );
  }
}
