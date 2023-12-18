import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:hive_flutter/adapters.dart';

import 'package:musicplayer/app/common/widget.dart';

import 'package:musicplayer/app/data/model/song_model.dart';
import 'package:musicplayer/app/modules/home/views/recently_playedview.dart';
import 'package:musicplayer/app/modules/library/controllers/tracks_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final HomeController controller = Get.find<HomeController>();
  final TrackController trackController = Get.put(TrackController());
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color.fromARGB(255, 19, 18, 18),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'MUSIFY',
          style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 70, 26, 26)),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.toNamed('/folder');
                        },
                        child: Image.asset(
                          'assets/folder.jpeg',
                          height: 100,
                          width: 200,
                        )),
                    CustomSizedBox(),
                    const Text('FOLDER'),
                  ],
                ),
              ],
            ),
          ),

          // ----Main Title: Playlists-----

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Playlists',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.add_circle,
                    size: 50,
                    color: Color.fromARGB(255, 61, 21, 21),
                  ),
                  onPressed: () async {
                    showCreatePlaylistDialog(context);
                    // }
                  },
                ),
              ],
            ),
          ),

// Playlist display
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: controller.musicBox.listenable(),
              builder: (context, musicBox, child) {
                // before craeting playlists

                if (musicBox.isEmpty) {
                  return Center(
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Image.asset(
                          'assets/noplaylist.jpg', // Replace with your creative image
                          height: 200,
                          width: 500,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Text(
                                "Oops! no playlists yet.\nStart creating and enjoying your music!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
//after adding playlists
                return SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: musicBox.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      String playlistName = musicBox.keyAt(index);

                      // Retrieve the playlist from the box, handle null case
                      Music? playlistNullable = musicBox.get(playlistName);
                      Music playlist = playlistNullable ?? Music(songs: []);

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Navigate to the PlaylistDisplayView with the selected playlist name
                                Get.toNamed('/playlistsdetail',
                                    arguments: {'playlistName': playlistName});
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset('assets/image2.jpeg',
                                    height: 150, width: 150),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              playlistName,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),

          //----Recently played--- //

          const Padding(
            padding: EdgeInsets.all(1),
            child: Text(
              'Recently Played',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),

          // List of Recently Played Songs

          Expanded(
            child: recentlyPlayedSongsWidget(),
          ),
        ],
      ),
    ); //future
  }

  Future<void> showCreatePlaylistDialog(BuildContext context) async {
    String playlistName = "";
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:  Color.fromARGB(255, 228, 235, 192),
          surfaceTintColor: const Color.fromARGB(255, 191, 16, 16),
          title: Text("Create Playlist",style: TextStyle(color: Colors.brown,fontWeight: FontWeight.bold)),
          content: TextField(
            onChanged: (value) {
              playlistName = value;
            },
            decoration: InputDecoration(
              labelText: "Playlist Name",
             // hintStyle: TextStyle(color: const Color.fromARGB(255, 230, 197, 197)),
               labelStyle: TextStyle(color: Colors.brown),
               focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: const Color.fromARGB(255, 237, 234, 233)),
    ),
    

              ),
              style:  TextStyle(color: const Color.fromARGB(255, 237, 234, 233)), // Text color while typing
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

  Widget recentlyPlayedSongsWidget() {
    return FutureBuilder<void>(
      // You might want to use FutureBuilder if loading recently played songs asynchronously
      future: trackController
          .loadRecentlyPlayed(), // Ensure you have this method in your TrackController
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // You can replace it with a loading indicator
        }
        //else if (snapshot.hasError) {
        // return Text('Error loading recently played songs: ${snapshot.error}');}

        else {
          return RecentlyPlayedScreen(); // Display RecentlyPlayedScreen widget
        }
      },
    );
  }
}
