import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:on_audio_query/on_audio_query.dart';



class AlbumsView extends StatefulWidget {
  @override
  _AlbumsViewState createState() => _AlbumsViewState();
}

class _AlbumsViewState extends State<AlbumsView> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    checkAndRequestPermissions();
  }

  checkAndRequestPermissions({bool retry = false}) async {
    // The param 'retryRequest' is false, by default.
    _hasPermission = await _audioQuery.checkAndRequest(
      retryRequest: retry,
    );

    // Only call update the UI if application has all required permissions.
    _hasPermission ? setState(() {}) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: !_hasPermission
          ? noAccessToLibraryWidget()
          : FutureBuilder<List<AlbumModel>>(
              future: _audioQuery.queryAlbums(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }

                final albums = snapshot.data;

                if (albums == null || albums.isEmpty) {
                  return const Text("No albums found!");
                }

                return ListView.builder(
                  itemCount: albums.length,
                  itemBuilder: (context, index) {
                    final album = albums[index];

                    if (album == null) {
                      // Handle the case when an album is null (optional)
                      return SizedBox.shrink();
                    }

                    return ListTile(
                      title: Text(album.album ?? ""),
                      subtitle: Text(album.numOfSongs?.toString() ?? ""),
                      leading: QueryArtworkWidget(
                        controller: _audioQuery,
                        id: album.id ,
                        type: ArtworkType.AUDIO,
                      ),
     onTap: () {
  final albumName = album.album?.toString() ?? "";
  final albumId = album.id?.toString() ?? "";

  if (albumName.isNotEmpty && albumId.isNotEmpty) {
    Get.toNamed('/albumSongsScreen', arguments: {
      'albumName': albumName,
      'albumId': albumId,
    });
  } else {
    print("Error: albumName or albumId is empty");
  }
},



                    );
                  },
                );
              },
            ),
      ),
    );
  }

  Widget noAccessToLibraryWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Application doesn't have access to the library"),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => checkAndRequestPermissions(),
            child: const Text("Allow"),
          ),
        ],
      ),
    );
  }
}
