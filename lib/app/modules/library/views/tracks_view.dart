// TracksView.dart
import 'package:flutter/material.dart';

import 'package:musicplayer/app/modules/bottomnavigationbar/controllers/bottomnavigationbar_controller.dart';
import 'package:musicplayer/app/modules/library/controllers/tracks_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'dart:io';

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

  @override
  void initState() {
    super.initState();
    checkAndRequestPermissions();
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
    setState(() {
      _songs = songs;
    });
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
                title: Text(_songs[index].title),
                subtitle: Text(_songs[index].artist ?? "No Artist"),
                leading: QueryArtworkWidget(
                  controller: trackController.audioQuery,
                  id: _songs[index].id,
                  type: ArtworkType.AUDIO,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.more_vert), // More Vert Icon
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
                                      final controller =
                                          Get.find<TrackController>();
                                      // Add the current song to favorites
                                      controller.addToFavorites(song);

                                      Navigator.pop(
                                          context); // Close the bottom sheet
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      // Handle add icon pressed

                                      Navigator.pop(
                                          context); // Close the bottom sheet
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () async {
                                      _showDeleteConfirmationDialog(
                                          _songs[index]);
                                      // Navigator.pop( context); // Close the bottom sheet
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
                  _showBottomMediaBar(_songs[index]);
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

  //delte
  Future<void> _showDeleteConfirmationDialog(SongModel song) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Song'),
          content: Text('Are you sure you want to delete this song?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  // Get the file path
                  String filePath = song.data ?? '';
                  // Check if the file exists
                  File file = File(filePath);
                  if (await file.exists()) {
                    // Delete the file
                    await file.delete();
                    // Now you can remove the song from your list
                    setState(() {
                      _songs.removeWhere((s) => s.id == song.id);
                    });
                    // Close the dialog
                    Navigator.of(context).pop();
                  } else {
                    // File doesn't exist
                    print('File does not exist: $filePath');
                    // Optionally, you can show a snackbar or display a message.
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Song file not found'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                    // Close the dialog even if the file doesn't exist
                    Navigator.of(context).pop();
                  }
                } catch (error) {
                  // Handle errors during file deletion
                  print('Error deleting file: $error');
                  // Optionally, you can show a snackbar or display an error message.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error deleting song: $error'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                  // Close the dialog
                  Navigator.of(context).pop();
                }
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }







//rename




//miniplayer
  void _showBottomMediaBar(SongModel song) {
    bool isInitiallyPlaying = trackController.audioPlayer.playing;

    bottomnavigationbarController.setMiniPlayerVisible(true);

    // Update the state of the mini-player widget
    bottomnavigationbarController.currentSong.value = song;
    bottomnavigationbarController.isPlaying.value = isInitiallyPlaying;

    // showModalBottomSheet(
    //   context: context,
    //   builder: (context) {
    //     return StatefulBuilder(
    //       builder: (BuildContext context, StateSetter setState) {
    //         return Container(
    //           decoration: BoxDecoration(
    //             color: Colors.yellow.shade100,
    //             boxShadow: [
    //               BoxShadow(
    //                 color: Colors.grey.withOpacity(0.5),
    //                 spreadRadius: 5,
    //                 blurRadius: 7,
    //                 offset: const Offset(0, 3),
    //               ),
    //             ],
    //           ),
    //           padding:
    //               const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               QueryArtworkWidget(
    //                 controller: trackController.audioQuery,
    //                 id: song.id,
    //                 type: ArtworkType.AUDIO,
    //               ),
    //               Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                     song.title,
    //                     style: TextStyle(
    //                         fontSize: 16, fontWeight: FontWeight.bold),
    //                   ),
    //                   Text(
    //                     song.artist ?? "No Artist",
    //                     style: TextStyle(fontSize: 14),
    //                   ),
    //                 ],
    //               ),
    //               IconButton(
    //                 icon: Icon(
    //                     isInitiallyPlaying ? Icons.pause : Icons.play_arrow),
    //                 onPressed: () {
    //                   isInitiallyPlaying
    //                       ? trackController.audioPlayer.pause()
    //                       : trackController.audioPlayer.play();
    //                   setState(() {
    //                     isInitiallyPlaying = !isInitiallyPlaying;
    //                   });
    //                 },
    //               ),
    //               IconButton(
    //                 icon: const Icon(Icons.skip_next),
    //                 onPressed: () {
    //                   // Logic to skip to the next track
    //                 },
    //               ),
    //             ],
    //           ),
    //         );
    //       },
    //     );
    //   },
    // );

    trackController.playSong(song);
  }

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

//seperate updated



