import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/app/data/model/song_model.dart';
import 'package:musicplayer/app/data/model/songmodel.dart';
import 'package:musicplayer/app/modules/bottomnavigationbar/controllers/bottomnavigationbar_controller.dart';
import 'package:musicplayer/app/modules/bottomnavigationbar/controllers/fullplayer.dart';
import 'package:musicplayer/app/modules/favourites/controllers/favourites_controller.dart';
import 'package:musicplayer/app/modules/home/controllers/home_controller.dart';
import 'package:musicplayer/app/modules/library/controllers/PlaylistNameSelectionController.dart';

import 'package:musicplayer/app/modules/library/controllers/artistandsongcontroller.dart';
import 'package:musicplayer/app/modules/library/controllers/tracks_controller.dart';
import 'package:musicplayer/app/modules/playlists/controllers/playlist_selection_controller_controller.dart';
import 'package:musicplayer/app/modules/playlists/controllers/playlists_controller.dart';
import 'package:musicplayer/app/modules/searchbar/controllers/searchbar_controller.dart';
import 'app/routes/app_pages.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Searchbar bindings
    Get.lazyPut<SearchbarController>(() => SearchbarController());
    Get.lazyPut<BottomnavigationbarController>(
        () => BottomnavigationbarController());
   // Playlist bindings
    Get.lazyPut<PlaylistSelectionController>(
        () => PlaylistSelectionController());
    Get.lazyPut<PlaylistDisplayController>(() => PlaylistDisplayController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<TrackController>(() => TrackController());

    Get.lazyPut<ArtistSongsController>(
        () => ArtistSongsController(Get.find<TrackController>()));

 

    Get.put<PlaylistNameSelectionController>(PlaylistNameSelectionController());

    Get.lazyPut<FavouritesController>(() => FavouritesController());

    Get.lazyPut<FullSongplayerController>(() => FullSongplayerController());
    //for tracksview to play song
    Get.put<AudioPlayer>(AudioPlayer());
  }
}

void main() async {
  //hive
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SongModelAdapter());
  Hive.registerAdapter(MusicAdapter());

//playlist hive box
  await Hive.openBox<Music>('musicBox');

//fav hive box
  await Hive.openBox<Music>('favorites');

//recently played
  await Hive.openBox<Music>('recently_played');

  Get.put(PlaylistSelectionController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBindings(),
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.white,
        textTheme: ThemeData.dark().textTheme.copyWith(
              // Set the text color to black for all text styles
              bodyLarge: TextStyle(color: Colors.black),
              bodyMedium: TextStyle(color: Colors.black),
              displayLarge: TextStyle(color: Colors.black),
              displayMedium: TextStyle(color: Colors.black),
              // Add more text styles as needed
            ),
      ),
    );
  }
}
