import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musicplayer/app/data/model/song_model.dart';
import 'package:musicplayer/app/modules/home/views/recently_playedview.dart';
import 'package:musicplayer/app/modules/home/widget/addnew_playlist.dart';
import 'package:musicplayer/app/modules/library/controllers/tracks_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  // final HomeController controller = Get.find<HomeController>();
  final TrackController trackController = Get.put(TrackController());
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: const Color.fromARGB(255, 19, 18, 18),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.white),
          centerTitle: true,
          title: const Text(
            'BEATEASE',
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 70, 26, 26)),
          ),
        ),
        body: Column(
       crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                      await showCreatePlaylistDialog(context);
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
                  return Expanded(
                    child: SizedBox(
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
                                        height: 140, width: 150),
                                  ),
                                ),
                                Text(
                                  playlistName,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
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
      ),
    ); //future
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
        else {
          return RecentlyPlayedScreen(); // Display RecentlyPlayedScreen widget
        }
      },
    );
  }
}
