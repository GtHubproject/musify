import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

// Widget ArtistsView() {
//   return ListView.builder(
//     itemCount: 5,
//     itemBuilder: (context, index) {
//       return ListTile(
//         title: Text('Artist $index'),
//         trailing: Icon(Icons.arrow_forward),
//         leading: Icon(Icons.person),
//       );
//     },
//   );
// }

class ArtistsView extends StatefulWidget {
  @override
  _ArtistsViewState createState() => _ArtistsViewState();
}

class _ArtistsViewState extends State<ArtistsView> {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    checkAndRequestPermissions();
  }

  checkAndRequestPermissions({bool retry = false}) async {
    _hasPermission = await _audioQuery.checkAndRequest(retryRequest: retry);
    _hasPermission ? setState(() {}) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:!_hasPermission
         ? noAccessToLibraryWidget()
            : FutureBuilder<List<ArtistModel>>(
                future: _audioQuery.queryArtists(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text("No artists found!");
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data![index].artist ?? "Unknown Artist"),
                        subtitle:
                              Text(snapshot.data![index].numberOfAlbums.toString()),
                        trailing: const Icon(Icons.arrow_forward),
                        leading: const Icon(Icons.person),
                      );
                    },
                  );
                },
              )
           
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

