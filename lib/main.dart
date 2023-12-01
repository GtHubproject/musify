import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/app/data/model/song_model.dart';
import 'package:musicplayer/app/data/model/songmodel.dart';
import 'package:musicplayer/app/modules/home/controllers/home_controller.dart';
import 'package:musicplayer/app/modules/playlists/controllers/playlist_selection_controller_controller.dart';
import 'package:musicplayer/app/modules/playlists/controllers/playlists_controller.dart';
import 'package:musicplayer/app/modules/searchbar/controllers/searchbar_controller.dart';
import 'package:musicplayer/constants/colors.dart';
import 'app/routes/app_pages.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Searchbar bindings
    Get.lazyPut<SearchbarController>(() => SearchbarController());

    // Playlist bindings
    Get.lazyPut<PlaylistSelectionController>(() => PlaylistSelectionController());
    Get.lazyPut<PlaylistDisplayController>(() => PlaylistDisplayController());
    Get.lazyPut<HomeController>(() => HomeController());
   //for tracksview to play song
   Get.put<AudioPlayer>(AudioPlayer()); 
    // Add other bindings as needed
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SongModelAdapter());
  Hive.registerAdapter(MusicAdapter()); 

//playlist

await Hive.openBox<Music>('musicBox');

await Hive.openBox<Music>('favorites');

//fav
//await Hive.openBox<Music>('favorites');
   Get.put(PlaylistSelectionController());
   runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
      initialBinding:AppBindings() ,
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme:
          ThemeData.dark().copyWith(scaffoldBackgroundColor: Colours.scafColor),
    );
  }
}
