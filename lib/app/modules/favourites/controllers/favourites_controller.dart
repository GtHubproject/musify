import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:musicplayer/app/data/model/song_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

// class FavouritesController extends GetxController {
//   //TODO: Implement FavouritesController

//   final count = 0.obs;
//   @override
//   void onInit() {
//     super.onInit();
//   }

//   @override
//   void onReady() {
//     super.onReady();
//   }

//   @override
//   void onClose() {
//     super.onClose();
//   }

//   void increment() => count.value++;
// }
class FavouritesController extends GetxController {
  //final ValueNotifier<int> boxChangeListener = ValueNotifier<int>(0);

  void removeFromPlaylist(SongModel song) {
    print("Removing song: ${song.title}");

    try {
      final favoritesBox = Hive.box<Music>('favorites');
      Music favorites =
          favoritesBox.get('favorites', defaultValue: Music(songs: []))!;
      favorites.songs.remove(song);
      favoritesBox.put('favorites', favorites);

      // Trigger a rebuild in the FavoritesScreen
    //  boxChangeListener.value++;

      // Directly trigger a rebuild
      if (Get.isRegistered<FavouritesController>()) {
        Get.find<FavouritesController>().update();
      }
// Get.find<FavouritesController>().update();

    } catch (e) {
      print("Error during Hive operation: $e");
    }
  }
}
