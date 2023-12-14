import 'package:flutter/material.dart';
import 'package:musicplayer/app/modules/bottomnavigationbar/controllers/bottomnavigationbar_controller.dart';
import 'package:musicplayer/app/modules/favourites/controllers/favourites_controller.dart';
import 'package:musicplayer/app/modules/library/controllers/tracks_controller.dart';
import 'package:musicplayer/app/modules/library/views/PlaylistNameSelectionView.dart';

import 'package:on_audio_query/on_audio_query.dart';

import 'package:get/get.dart';

class TracksView extends StatefulWidget {
  const TracksView({Key? key}) : super(key: key);

  @override
  _TracksViewState createState() => _TracksViewState();
}

class _TracksViewState extends State<TracksView> {
  final TrackController trackController = Get.put(TrackController());

  BottomnavigationbarController bottomnavigationbarController =
      Get.put(BottomnavigationbarController());

  List<SongModel> _songs = [];
  bool _hasPermission = false;

  // SongModel selectedSong = SongModel({});
  @override
  void initState() {
    super.initState();
    checkAndRequestPermissions();
    trackController.loadRecentlyPlayed();
  }

  Future<void> checkAndRequestPermissions({bool retry = false}) async {
    bool hasPermission = await trackController.checkPermission();
    setState(() {
      _hasPermission = hasPermission;
    });

    if (_hasPermission) {
      loadSongs();
    } else if (retry) {
      // Handle retry logic if needed
    }
  }

  Future<void> loadSongs() async {
    List<SongModel> songs = await trackController.querySongs();
    //for the minplayer playnext song feature

    bottomnavigationbarController.setSongs(songs); // Set the list of songs
    setState(() {
      _songs = songs;
    });
  }

//for addin playlist
 Future<void> addToPlaylist(SongModel selectedSong) async {
    // Navigate to the playlist selection screen
    await Get.to(() => PlaylistNameSelectionView());

    // The PlaylistNameSelectionController will handle adding the song to the selected playlist
  }



  Widget _buildTrackList() {
    return FutureBuilder<List<SongModel>>(
      future: trackController.querySongs(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          _songs = snapshot.data!;

          return ListView.builder(
            itemCount: _songs.length,
            itemBuilder: (context, index) {
              var song = _songs[index];
              return ListTile(
                title: Text(
                  _songs[index].title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                subtitle: Text(
                  _songs[index].artist ?? "No Artist",
                  style: TextStyle(
                      fontWeight: FontWeight.w400, color: Colors.black),
                ),
                leading: QueryArtworkWidget(
                  controller: trackController.audioQuery,
                  id: _songs[index].id,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: Container(
                    width: 70,
                    height: 90,
                    color: Color.fromARGB(235, 131, 83, 76),
                    child: Icon(Icons.music_note),
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.brown,
                      ), // More Vert Icon

                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.favorite),
                                    onPressed: () {
                                      // Call the addToFavorites method from the TracksController
                                      trackController.addToFavorites(song);
                                      // Notify the FavouritesController to trigger a rebuild
                                      Get.find<FavouritesController>().update();
                                      // final controller = Get.find<TrackController>();
                                      // Add the current song to favorites
                                      //controller.addToFavorites(song);

                                      Navigator.pop(
                                          context); // Close the bottom sheet
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: ()async {

                                      // Set the selected song when Add is pressed
                             trackController.selectedSong = song;
                                      await addToPlaylist(_songs[index]);
                                      Navigator.pop(context);

                                      // Close the bottom sheet
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                onTap: () {
                  bottomnavigationbarController.playSong(_songs[index]);
                  //   _showBottomMediaBar(_songs[index]);

                  // bottomnavigationbarController.playSong(_songs[index]);
                  bottomnavigationbarController.update();
                  trackController.addRecentlyPlayed(_songs[index]);
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

  SongModel getSelectedSong(SongModel song) {
    // Logic to get or initialize the selected song
    return song;
  }

// void _showAddToPlaylistDialog(BuildContext context, SongModel selectedSong) {
//   showModalBottomSheet(
//     context: context,
//     builder: (BuildContext context) {
//       return Container(
//        child:PlaylistNameListingView(selectedSong: selectedSong),
//       );
//     },
//   );
// }

  Widget noAccessToLibraryWidget() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Application doesn't have access to the library"),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => checkAndRequestPermissions(retry: true),
            child: const Text("Allow"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _hasPermission ? _buildTrackList() : noAccessToLibraryWidget(),
      ),
    );
  }
}
