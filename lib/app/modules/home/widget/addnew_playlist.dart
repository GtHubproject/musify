 import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:musicplayer/app/modules/home/controllers/home_controller.dart';

Future<void> showCreatePlaylistDialog(BuildContext context) async {

   final HomeController controller = Get.find<HomeController>();
    String playlistName = "";
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:  Color.fromARGB(255, 228, 235, 192),
          surfaceTintColor: const Color.fromARGB(255, 191, 16, 16),
          title: Text("Create Playlist",style: TextStyle(color: Colors.brown,fontWeight: FontWeight.bold)),

          content: TextSelectionTheme(
          data: TextSelectionThemeData(
            cursorColor: Color.fromARGB(255, 49, 17, 15), // Set the desired cursor color
          ),
          child: TextField(
            onChanged: (value) {
              playlistName = value;
            },
            decoration: InputDecoration(
              labelText: "Playlist Name",
              labelStyle: TextStyle(color: Colors.brown),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 50, 23, 14)),
              ),
            ),
            style: TextStyle(color: Color.fromARGB(255, 53, 53, 19)), // Text color while typing
          ),
        ),
         
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel',style: TextStyle(color: Colors.brown),),
            ),
            TextButton(
              onPressed: () async {
                if (playlistName.isNotEmpty) {
                  await controller.createPlaylist(playlistName);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Create',style: TextStyle(color: Colors.brown)),
            ),
          ],
        );
      },
    );
  }
