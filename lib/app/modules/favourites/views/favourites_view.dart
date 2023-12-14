import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:musicplayer/app/data/model/song_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../controllers/favourites_controller.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
// Replace with the actual path to your song_model.dart file

// class FavouritesView extends StatefulWidget {
//   @override
//   State<FavouritesView> createState() => _FavouritesViewState();
// }

// class _FavouritesViewState extends State<FavouritesView> {
//  // final ValueNotifier<int> boxChangeListener = ValueNotifier<int>(0);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Favorite Songs'),
//       ),
//       body: _buildFavoritesList(),
//     );
//   }

//   Widget _buildFavoritesList() {
//     final favoritesBox = Hive.box<Music>('favorites');

//     // Create a ValueNotifier to listen for changes
//     //final ValueNotifier<int> boxChangeListener = ValueNotifier<int>(0);

//     return FutureBuilder(
//       future: Hive.openBox<Music>('favorites'),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           final List<SongModel> favoriteSongs =
//               (favoritesBox.get('favorites', defaultValue: Music(songs: [])) ??
//                       Music(songs: []))
//                   .songs;

//           if (favoriteSongs.isEmpty) {
//             return Center(
//               child: Text('No favorite songs yet!'),
//             );
//           }

//           return ListView.builder(
//             itemCount: favoriteSongs.length,
//             itemBuilder: (context, index) {
//               var song = favoriteSongs[index];

//               // return ValueListenableBuilder<int>(
//               //   valueListenable: boxChangeListener,
//               //   builder: (context, value, child) {
//                 //  print("Rebuilding with value: $value");
//                   return ListTile(
//                     title: Text(song.title),
//                     subtitle: Text(song.artist ?? 'No Artist'),
//                     trailing: IconButton(
//                       icon: Icon(Icons.favorite,
//                           color: Colors.red), // Red color favorite icon
//                       onPressed: () {
//                         _removeFromPlaylist(song);
//                       },
//                     ),
//                     // Add other details or actions as needed
//                   );
//                 },
//              // );
//            // },
//           );
//         } else {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//       },
//     );
//   }

//   void _removeFromPlaylist(SongModel song) {
//     print("Removing song: ${song.title}");

//     try {
//       final favoritesBox = Hive.box<Music>('favorites');
//       Music favorites =
//           favoritesBox.get('favorites', defaultValue: Music(songs: []))!;
//       favorites.songs.remove(song);
//       favoritesBox.put('favorites', favorites);

     
//     // Trigger a rebuild in the FavoritesScreen
//    // print("Before triggering rebuild: ${boxChangeListener.value}");
//     //boxChangeListener.value++;
//    // print("After triggering rebuild: ${boxChangeListener.value}");


//      // Directly trigger a rebuild
//     if (mounted) {
//       setState(() {});
//     }
//     } catch (e) {
//       print("Error during Hive operation: $e");
//     }
//   }
// }

class FavouritesView extends GetView<FavouritesController> {
  const FavouritesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Songs'),
      ),
      body: _buildFavoritesList(),
    );
  }

  Widget _buildFavoritesList() {
    return GetBuilder<FavouritesController>(
      builder: (controller) {
        final favoritesBox = Hive.box<Music>('favorites');
        final List<SongModel> favoriteSongs =
            (favoritesBox.get('favorites', defaultValue: Music(songs: [])) ??
                    Music(songs: []))
                .songs;

        if (favoriteSongs.isEmpty) {
          return Center(
            child: Text('No favorite songs yet!'),
          );
        }

        return ListView.builder(
          itemCount: favoriteSongs.length,
          itemBuilder: (context, index) {
            var song = favoriteSongs[index];

            return ListTile(
              title: Text(song.title,style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),),
              subtitle: Text(song.artist ?? 'No Artist', style: TextStyle(
                      fontWeight: FontWeight.w400, color: Colors.black),),
              trailing: IconButton(
                icon: Icon(Icons.favorite, color: Colors.red),
                onPressed: () {
                  controller.removeFromPlaylist(song);
                },
              ),
            );
          },
        );
      },
    );
  }
}

