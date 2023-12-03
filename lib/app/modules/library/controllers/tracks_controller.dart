import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive/hive.dart';
import 'package:musicplayer/app/data/model/song_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class TrackController extends GetxController {
  final OnAudioQuery audioQuery = OnAudioQuery();
  final AudioPlayer audioPlayer = AudioPlayer();

   late Box<Music> favoritesBox;
  late ValueNotifier<int> boxChangeListener;
  //deelte song
 List<SongModel> _songs = [];

List<SongModel> get songs => _songs;
  // Hive box for storing favorite songs

  @override
  void onInit() async {
    super.onInit();

    // Initialize the Hive box for favorites
 await Hive.openBox<Music>('favorites');
    favoritesBox = Hive.box<Music>('favorites');

    //Create the ValueNotifier and pass it to the FavoritesScreen
     boxChangeListener = ValueNotifier<int>(0);
  }

  Future<bool> checkPermission() async {
    var permissionStatus = await audioQuery.permissionsStatus();
    if (permissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return await audioQuery.permissionsRequest();
    }
  }

  Future<List<SongModel>> querySongs() async {
    return audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
  }

  // Method to add a song to the favorites Hive box
  void addToFavorites(SongModel song) {
    try {
      // Get the existing favorites or create a new one
      Music favorites =
          favoritesBox.get('favorites', defaultValue: Music(songs: []))!;

      // Add the song to the favorites
      favorites.songs.add(song);

      // Save the updated favorites back to the Hive box
      favoritesBox.put('favorites', favorites);
      // Trigger a rebuild in the FavoritesScreen
     boxChangeListener.value++;
      print("added");
    } catch (e) {
      // Handle exceptions, e.g., log the error or show a user-friendly message
      print('Error adding song to favorites: $e');
      // You can also rethrow the exception if needed
      // rethrow;
    }
  }

  Future<void> playSong(SongModel song) async {
    await audioPlayer.stop();
    await audioPlayer.setUrl(song.data);
    await audioPlayer.play();
  }


Future<void> deleteSong(String songId) async {
  print('Deleting song with ID: $songId');

  // Assuming there is no direct method to delete by ID
  // Fetch the updated list of songs excluding the one to be deleted
  List<SongModel> updatedSongs = await querySongs();
  updatedSongs.removeWhere((song) => song.id == songId);

  // Update the local list of songs
  _songs = updatedSongs;

  // Trigger a rebuild
  update();

  print('Song deleted. Songs after deletion: $_songs');
}



  
}
