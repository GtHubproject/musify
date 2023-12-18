import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:musicplayer/app/data/model/song_model.dart';
import 'package:musicplayer/app/modules/bottomnavigationbar/controllers/bottomnavigationbar_controller.dart';
import 'package:musicplayer/app/modules/library/controllers/tracks_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../controllers/favourites_controller.dart';


import 'package:hive/hive.dart';


class FavouritesView extends GetView<FavouritesController> {
  FavouritesView({Key? key}) : super(key: key);

  BottomnavigationbarController bottomnavigationbarController =
      Get.put(BottomnavigationbarController());

       final TrackController trackController = Get.put(TrackController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor:   Color.fromARGB(255, 63, 29, 29),
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
              title: Text(
                song.title,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              subtitle: Text(
                song.artist ?? 'No Artist',
                style:
                    TextStyle(fontWeight: FontWeight.w400, color: Colors.black),
              ),
              trailing: IconButton(
                icon: Icon(Icons.favorite, color: Colors.red),
                onPressed: () {
                  controller.removeFromPlaylist(song);
                },
              ),
              onTap: () {
                bottomnavigationbarController.playSongFromList(song, favoriteSongs);
                trackController.addRecentlyPlayed(song);

              },
            );
          },
        );
      },
    );
  }
}
