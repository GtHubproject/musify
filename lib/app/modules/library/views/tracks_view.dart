// TracksView.dart
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class TracksView extends StatefulWidget {
  const TracksView({Key? key}) : super(key: key);

  @override
  _TracksViewState createState() => _TracksViewState();
}

class _TracksViewState extends State<TracksView> {
  //late Box<PlaylistModel> playlistBox;

  final OnAudioQuery _audioQuery = OnAudioQuery();
  bool _hasPermission = false;
  late AudioPlayer _audioPlayer;
  List<SongModel> _songs = [];
  bool _isPlaying = false;
  SongModel? _currentSong;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    checkAndRequestPermissions();
    _initAudioPlayer();
    // playlistBox = Hive.box<PlaylistModel>('playlists');
  }

  void _initAudioPlayer() {
    _audioPlayer.playerStateStream.listen((playerState) {
      setState(() {
        _isPlaying = playerState.playing;
      });
    });
  }

  Future<void> checkAndRequestPermissions({bool retry = false}) async {
    bool hasPermission = await _audioQuery.checkAndRequest(retryRequest: retry);
    setState(() {
      _hasPermission = hasPermission;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _hasPermission ? _buildTrackList() : noAccessToLibraryWidget(),
      ),
    );
  }

  Widget _buildTrackList() {
    return FutureBuilder<List<SongModel>>(
      future: _audioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          _songs = snapshot.data!;
          return ListView.builder(
            itemCount: _songs.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_songs[index].title),
                subtitle: Text(_songs[index].artist ?? "No Artist"),
                leading: QueryArtworkWidget(
                  controller: _audioQuery,
                  id: _songs[index].id,
                  type: ArtworkType.AUDIO,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.favorite), // Favorite Icon
                      onPressed: () {
                        // Logic for handling the favorite action
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.more_vert), // More Vert Icon
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(Icons.edit),
                                    title: Text('Rename'),
                                    onTap: () {
                                      // _renameSong(_songs[index]); // Call the method to handle renaming
                                      Navigator.pop(
                                          context); // Close the bottom sheet
                                      // Close the bottom sheet
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.playlist_add),
                                    title: Text('Add to Playlist'),
                                    onTap: () {
                                      // Logic for adding to playlist
                                      Navigator.pop(
                                          context); // Close the bottom sheet
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

  void _showBottomMediaBar(SongModel song) {
    _currentSong = song;

    bool isInitiallyPlaying = _audioPlayer.playing;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.yellow.shade100,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  QueryArtworkWidget(
                    controller: _audioQuery,
                    id: song.id,
                    type: ArtworkType.AUDIO,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        song.title,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        song.artist ?? "No Artist",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                        isInitiallyPlaying ? Icons.pause : Icons.play_arrow),
                    onPressed: () {
                      isInitiallyPlaying
                          ? _audioPlayer.pause()
                          : _audioPlayer.play();
                      setState(() {
                        isInitiallyPlaying = !isInitiallyPlaying;
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.skip_next),
                    onPressed: () {
                      // Logic to skip to the next track
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    _playSong(song);
  }

  Future<void> _playSong(SongModel song) async {
    _currentSong = song;
    await _audioPlayer.stop();
    await _audioPlayer.setUrl(song.data);
    await _audioPlayer.play();
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
}
