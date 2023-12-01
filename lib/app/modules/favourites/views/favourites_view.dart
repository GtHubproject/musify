import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:musicplayer/app/data/model/song_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../controllers/favourites_controller.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
 // Replace with the actual path to your song_model.dart file

class FavouritesView extends StatelessWidget {
   final ValueNotifier<int> boxChangeListener = ValueNotifier<int>(0);
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
    final favoritesBox = Hive.box<Music>('favorites');

    // Create a ValueNotifier to listen for changes
    final ValueNotifier<int> boxChangeListener = ValueNotifier<int>(0);

    return FutureBuilder(
      future: Hive.openBox<Music>('favorites'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<SongModel> favoriteSongs =
              (favoritesBox.get('favorites', defaultValue: Music(songs: [])) ?? Music(songs: []))
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
              return ValueListenableBuilder<int>(
                valueListenable: boxChangeListener,
                builder: (context, value, child) {
                  return ListTile(
                    title: Text(song.title),
                    subtitle: Text(song.artist ?? 'No Artist'),
                     trailing: IconButton(
            icon: Icon(Icons.favorite, color: Colors.red), // Red color favorite icon
            onPressed: () {
              _removeFromPlaylist(song);
            },
          ),
                    // Add other details or actions as needed
                  );
                },
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

void _removeFromPlaylist(SongModel song) {
    final favoritesBox = Hive.box<Music>('favorites');
    Music favorites = favoritesBox.get('favorites', defaultValue: Music(songs: []))!;
    favorites.songs.remove(song);
    favoritesBox.put('favorites', favorites);
  }
// void addToFavorites(SongModel song) {
//     Music favorites = favoritesBox.get('favorites', defaultValue: Music(songs: []))!;
//     favorites.songs.add(song);
//     favoritesBox.put('favorites', favorites);

//     // Trigger a rebuild in the FavoritesScreen
//     boxChangeListener.value++;
//   }

}
