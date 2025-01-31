import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive/hive.dart';
import 'package:musicplayer/app/data/model/song_model.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import 'package:permission_handler/permission_handler.dart';

class TrackController extends GetxController {
  final OnAudioQuery audioQuery = OnAudioQuery();
  final AudioPlayer audioPlayer = AudioPlayer();
  
  //to recent screen automatically updating

 Rx<Music> recentlyPlayedSongs = Music(songs: []).obs;


  late Box<Music> favoritesBox;
  late ValueNotifier<int> boxChangeListener;
//recently played

  late final Box<Music> recentlyPlayedBox;
  final int maxRecentlyPlayed =
      10; // Adjust the number of recently played songs to store

//for  adding song into playlists  from tracks
  SongModel? selectedSong;

  @override
  void onInit() async {
    super.onInit();

    // Initialize the Hive box for favorites
    await Hive.openBox<Music>('favorites');
    favoritesBox = Hive.box<Music>('favorites');

    // Initialize the Hive box for recently played songs
    await Hive.openBox<Music>('recently_played');
    recentlyPlayedBox = Hive.box<Music>('recently_played');
    loadRecentlyPlayed();
    //Create the ValueNotifier and pass it to the FavoritesScreen
    boxChangeListener = ValueNotifier<int>(0);
  }

//for adding to playlist
  SongModel? getSelectedSong() {
    return selectedSong;
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
      sortType: SongSortType.DISPLAY_NAME,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
  }

  void addToFavorites(SongModel song) {
    try {
      Music favorites =
          favoritesBox.get('favorites', defaultValue: Music(songs: []))!;
      print("Existing favorites: ${favorites.songs}");

      if (!favorites.songs.contains(song)) {
        favorites.songs.add(song);
        print("Song added: ${song.title}");

        favoritesBox.put('favorites', favorites);
        update();
        boxChangeListener.value++;
        print("Favorites after update: ${favoritesBox.get('favorites')}");
      } else {
        print("Song is already in favorites");
      }
    } catch (e) {
      print('Error adding song to favorites: $e');
    }
  }

  Future<void> playSong(SongModel song) async {
    await audioPlayer.stop();
    await audioPlayer.setUrl(song.data);
    await audioPlayer.play();
  }

  Future<void> addRecentlyPlayed(SongModel song) async {
    try {
      // Get the existing recently played songs or create a new one
      Music recentlyPlayed = recentlyPlayedBox.get('recently_played',
          defaultValue: Music(songs: []))!;

      print('Before adding: ${recentlyPlayed.songs.map((s) => s.title)}');

      // Add the song to the recently played list
      recentlyPlayed.songs.insert(0, song);

      // Limit the recently played list to a certain number
      if (recentlyPlayed.songs.length > maxRecentlyPlayed) {
        recentlyPlayed.songs.removeLast();
      }

      print('After adding: ${recentlyPlayed.songs.map((s) => s.title)}');

      // Save the updated recently played list back to the Hive box
      recentlyPlayedBox.put('recently_played', recentlyPlayed);

      print('Successfully added recently played song: ${song.title}');
    } catch (e) {
      print('Error adding recently played song: $e');
    }
  }

  //load recent
  // Load recently played songs from Hive box
  Future<void> loadRecentlyPlayed() async {
    try {
      Music recentlyPlayed = recentlyPlayedBox.get('recently_played',
          defaultValue: Music(songs: []))!;

      // Sort recently played songs by dateAdded, assuming SongModel has a dateAdded field
      recentlyPlayed.songs.sort((a, b) => b.dateAdded!.compareTo(a.dateAdded!));

      // Limit the recently played list to a certain number
      if (recentlyPlayed.songs.length > maxRecentlyPlayed) {
        recentlyPlayed.songs
            .removeRange(maxRecentlyPlayed, recentlyPlayed.songs.length);
      }

      // Save the updated recently played list back to the Hive box
      recentlyPlayedBox.put('recently_played', recentlyPlayed);
    } catch (e) {
      //LateError (LateInitializationError: Field 'recentlyPlayedBox' has not been initialized.)
      print('Error loading recently played songs: $e');
      rethrow; // You can rethrow the exception if needed
    }
  }
}
