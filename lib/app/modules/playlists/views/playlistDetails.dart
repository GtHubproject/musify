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

class  PlaylistsView extends GetView<PlaylistsController> {
   PlaylistsView({Key? key}) : super(key: key);
   @override
  Widget build(BuildContext context) {

    final OnAudioQuery _audioQuery = OnAudioQuery();
    return Scaffold(
      
      body:_buildSongList(),
    );
  }
  Widget _buildSongList() {
    return ValueListenableBuilder<Box<Playlist>>(
      valueListenable: Boxes.getPlaylist().listenable(),
      builder: (BuildContext context, box, _) {
        // Assuming you have a selectedPlaylist variable in your controller
    //    Playlist selectedPlaylist = controller.selectedPlaylist.value;

        return ListView.builder(
        //  itemCount: selectedPlaylist.songPaths.length,
          itemBuilder: (context, index) {

            
            // You need to fetch SongModel based on songPaths[index]
          
            // Replace the SongModel fetch logic with your actual implementation
         //   SongModel song = _fetchSongModel(selectedPlaylist.songPaths[index]);

            // return ListTile(
            //   title: Text(song.title),
            //   subtitle: Text(song.artist ?? "No Artist"),
            //   // Add other necessary UI elements for the song
            // );
          },
        );
      },
    );
  }



  // Replace this with your actual implementation to fetch SongModel
   
  // SongModel _fetchSongModel(String songPath) {
  //   List<SongModel> songs = _audioQuery.querySongs(
  //     sortType: null,
  //     orderType: OrderType.ASC_OR_SMALLER,
  //     uriType: UriType.EXTERNAL,
  //     ignoreCase: true,
  //   ) as List<SongModel>;

  //   SongModel? foundSong = songs.firstWhere(
  //     (song) => song.data == songPath,
  //     orElse: () => SongModel(title: 'Unknown Song', artist: 'Unknown Artist', data: ''),
  //   );

   // return foundSong!;
  }
  



