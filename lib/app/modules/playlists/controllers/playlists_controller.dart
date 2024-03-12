import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:musicplayer/app/data/model/song_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistDisplayController extends GetxController {
  final musicBox = Hive.box<Music>('musicBox');
  late String playlistName;

  @override
  void onInit() {
    // Retrieve the selected playlist name from the navigation arguments
    playlistName = Get.arguments['playlistName'];
  super.onInit();
  }
//to remove song in a playlist
   void removeSongFromPlaylist(SongModel song) {
    // Remove the song from the playlist and update the Hive box
    Music playlist = musicBox.get(playlistName) ?? Music(songs: []);
    playlist.songs.remove(song);
    musicBox.put(playlistName, playlist);
  }
//to delete a palylist
void showDeleteDialog(BuildContext context) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog( backgroundColor:  Color.fromARGB(255, 228, 235, 192),
                      title: Text('Delete', style: TextStyle(color: Colors.brown,fontWeight: FontWeight.bold)),
                      content: Text('Are you sure to delete?', 
                      style: TextStyle(color: Colors.brown,fontWeight: FontWeight.bold)),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Cancel',style: TextStyle(color: Colors.brown)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('OK',style: TextStyle(color: Colors.brown)),
                          onPressed: () {
                            deletePlaylist();
                            print('Deleting...');
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }

//fn to delete playlist
 void deletePlaylist() {
    // Implement logic to delete the playlist
    musicBox.delete(playlistName);
    // Navigate back to the previous screen or perform any other necessary actions
    Get.back();
  }
//to rename playlist
   void showRenameDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newPlaylistName = playlistName; // Default to current playlist name

        return AlertDialog(
           backgroundColor:  Color.fromARGB(255, 228, 235, 192),
          title: Text('Rename Playlist', style: TextStyle(color: Colors.brown,fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Playlist Name',

                  labelStyle: TextStyle(color: Colors.brown),
               focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: const Color.fromARGB(255, 237, 234, 233)),
    ),
                ),
onChanged: (value) {
                  newPlaylistName = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel',style: TextStyle(color: Colors.brown)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK',style: TextStyle(color: Colors.brown)),
              onPressed: () {
                // Handle renaming logic here
                renamePlaylist(newPlaylistName);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
//rename fn
void renamePlaylist(String newName) {
    // Implement logic to rename the playlist
    Music playlist = musicBox.get(playlistName) ?? Music(songs: []);
    musicBox.delete(playlistName);
    musicBox.put(newName, playlist);
    // Update the current playlistName
    playlistName = newName;
   
    Get.back();
  }

}

