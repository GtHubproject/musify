import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
//import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musicplayer/app/data/model/box.dart';
import 'package:musicplayer/app/data/model/song_model.dart';
import 'package:musicplayer/app/modules/bottomnavigationbar/controllers/bottomnavigationbar_controller.dart';
import 'package:musicplayer/app/modules/library/controllers/tracks_controller.dart';
import 'package:musicplayer/app/modules/playlists/widgets/renameDialog.dart';
import 'package:musicplayer/app/modules/playlists/widgets/showDeleteDialog.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../controllers/playlists_controller.dart';

class PlaylistDisplayView extends GetView<PlaylistDisplayController> {
  PlaylistDisplayView({Key? key}) : super(key: key);
  final PlaylistDisplayController controller =
      Get.find<PlaylistDisplayController>();

  BottomnavigationbarController bottomnavigationbarController =
      Get.put(BottomnavigationbarController());

  final TrackController trackController = Get.put(TrackController());
 // List<SongModel> _songs = [];

  @override
  Widget build(BuildContext context) {
    // Handle null case by providing a default playlistName if it's null
    String playlistName = controller.playlistName;
    //  String playlistName = controller.playlistName ?? '';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
         backgroundColor:   Color.fromARGB(255, 63, 29, 29),
        title: Text(playlistName),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.toNamed('/selectplaylist',
                  arguments: {'playlistName': controller.playlistName});
            },
          ),
          PopupMenuButton(color:  const Color.fromARGB(255, 216, 209, 149),
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry>[
                PopupMenuItem(
                  child: ListTile(tileColor:  const Color.fromARGB(255, 216, 209, 149),
                    leading: Icon(Icons.edit,color: Colors.black),
                    title: Text('Rename',style: TextStyle(color: Colors.black)),
                  ),
                  value: 'rename',
                ),
                PopupMenuItem(
                  child: ListTile(tileColor:  const Color.fromARGB(255, 216, 209, 149),
                    leading: Icon(Icons.delete,color: Colors.black,),
                    title: Text('Delete',style: TextStyle(color: Colors.black),),
                  ),
                  value: 'delete',
                ),
              ];
            },
            onSelected: (value) {
              if (value == 'rename') {
                controller.showRenameDialog(context);
              } else if (value == 'delete') {
                controller.showDeleteDialog(context);
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
        // Retrieve the selected playlist from the box
        Music? playlist = musicBox.get(controller.playlistName);

      


        return ListView.builder(
          itemCount: playlist!.songs.length,
          itemBuilder: (context, index) {
            SongModel song = playlist.songs[index];

            return ListTile(
              onTap: () {
                  bottomnavigationbarController.playSongFromList(song, playlist.songs);
                 // Update the current song in bottomnavigationbarController
          // bottomnavigationbarController.setCurrentSong(song);
                bottomnavigationbarController.update();
                trackController.addRecentlyPlayed(song);
              },

              title: Text(song.title, style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),),
              subtitle: Text(song.artist ?? "No Artist"  ,style: TextStyle(
                      fontWeight: FontWeight.w400, color: Colors.black),),

              trailing: IconButton(
                icon: Icon(Icons.delete ,color: Color.fromARGB(255, 247, 150, 112)),
                onPressed: () {
                  controller.removeSongFromPlaylist(song);
                },
              ),
              // Add more song details or onTap functionality as needed
            );
          },
        );
      },
    );
  }

 
}
