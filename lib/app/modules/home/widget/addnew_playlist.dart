import 'package:flutter/material.dart';
import 'package:musicplayer/app/data/model/box.dart';
import 'package:musicplayer/app/data/model/song_model.dart';

void showPlaylistDialog(BuildContext context) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      TextEditingController playlistNameController = TextEditingController();
      return AlertDialog(
        backgroundColor: Colors.white12,
        title: Text(
          'Creating New Playlist',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
             
              decoration: InputDecoration(
                //labelText: 'Playlist',
                filled: true,
                fillColor: Colors.yellow.shade50,
              ),
              controller:playlistNameController,
            ),
            SizedBox(height: 20),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel', style: TextStyle(color: Colors.amberAccent)),
          ),

          //--------ok--------//

          TextButton(
             onPressed: () {
              String playlistName = playlistNameController.text;
              Playlist playlist =
                  Playlist(playlistName: playlistName, songPaths: []);
              Boxes.getPlaylist().add(playlist);
               Navigator.pop(context);
            },
            child: Text(
              'OK',
              style: TextStyle(color: Colors.amberAccent),
            ),
          ),
        ],
      );
    },
  );
}
