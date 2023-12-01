import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

// class AlbumsView extends StatefulWidget {
//   @override
//   _AlbumsViewState createState() => _AlbumsViewState();
// }

// class _AlbumsViewState extends State<AlbumsView> {
//   final OnAudioQuery _audioQuery = OnAudioQuery();
//   bool _hasPermission = false;

//   @override
//   void initState() {
//     super.initState();
//     checkAndRequestPermissions();
//   }

//   checkAndRequestPermissions() async {
//     _hasPermission = (await _audioQuery.permissionsStatus) as bool;
//     if (!_hasPermission) {
//       _hasPermission = await _audioQuery.permissionsRequest();
//     }
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _hasPermission
//             ? FutureBuilder<List<AlbumModel>>(
//                 future: _audioQuery.queryAlbums(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasError) {
//                     return Text(snapshot.error.toString());
//                   }

//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const CircularProgressIndicator();
//                   }

//                   if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return const Text("No albums found!");
//                   }

//                   return ListView.builder(
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text(snapshot.data![index].albumName),
//                         subtitle: Text(snapshot.data![index].numberOfSongs.toString()),
//                         // Add further functionalities if needed
//                       );
//                     },
//                   );
//                 },
//               )
//             : noAccessToLibraryWidget(),
//       ),
//     );
//   }

//   Widget noAccessToLibraryWidget() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Text("Application doesn't have access to the library"),
//           const SizedBox(height: 10),
//           ElevatedButton(
//             onPressed: () => checkAndRequestPermissions(),
//             child: const Text("Allow"),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
                future: _audioQuery.queryAlbums(

                ),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text("No albums found!");
                  }

                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(

                          title: Text(snapshot.data![index].album),
                          subtitle:
                              Text(snapshot.data![index].numOfSongs.toString()),
                               leading: QueryArtworkWidget(
                          controller: _audioQuery,
                          id: snapshot.data![index].id,
                          type: ArtworkType.AUDIO,
                        ),
                        );
                      });
                })
           
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
