import 'package:get/get.dart';
import 'package:musicplayer/app/modules/bottomnavigationbar/views/fullplayer.dart';
import 'package:musicplayer/app/modules/library/views/PlaylistNameSelectionView.dart';
import 'package:musicplayer/app/modules/library/views/albumsong.dart';
import 'package:musicplayer/app/modules/library/views/artistandsong.dart';
import 'package:musicplayer/app/modules/playlists/views/playlistDetails.dart';
import 'package:musicplayer/app/modules/playlists/views/playlist_selection_screen_view.dart';

import '../modules/bottomnavigationbar/bindings/bottomnavigationbar_binding.dart';
import '../modules/bottomnavigationbar/views/bottomnavigationbar_view.dart';
import '../modules/download/bindings/download_binding.dart';
import '../modules/download/views/download_view.dart';
import '../modules/favourites/bindings/favourites_binding.dart';
import '../modules/favourites/views/favourites_view.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/library/bindings/library_binding.dart';
import '../modules/library/views/library_view.dart';

import '../modules/permission/bindings/permission_binding.dart';
import '../modules/permission/views/permission_view.dart';
import '../modules/playlists/bindings/playlists_binding.dart';


import '../modules/searchbar/bindings/searchbar_binding.dart';
import '../modules/searchbar/views/searchbar_view.dart';
import '../modules/splash/splashscreen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LIBRARY,
      page: () => const LibraryView(),
      binding: LibraryBinding(),
    ),
   
    GetPage(
      name: _Paths.FAVOURITES,
      page: () => FavouritesView(),
      binding: FavouritesBinding(),
    ),
    GetPage(
      name: _Paths.PLAYLISTS,
      page: () => PlaylistDisplayView(),
      binding: PlaylistsBinding(),
    ),

    GetPage(
      name: _Paths.SELECTPLAYLIST,
      page: () => PlaylistSelectionView(),
      //binding: PlaylistsBinding(),
    ),

    GetPage(
      name: _Paths.NAMESELECTION  ,
      page: () => PlaylistNameSelectionView(),
      //binding: PlaylistsBinding(),
    ),
    GetPage(
      name: _Paths.SEARCHBAR,
      page: () => SearchbarView(),
      binding: SearchbarBinding(),
    ),

    GetPage(
      name: _Paths.BOTTOMNAVIGATIONBAR,
      page: () => BottomnavigationbarView(),
      binding: BottomnavigationbarBinding(),
    ),
   
    GetPage(
      name: _Paths.PERMISSION,
      page: () => const PermissionView(),
      binding: PermissionBinding(),
    ),

     GetPage(
      name: _Paths.FULLPLAYER,
      page: () =>  FullSongplayerView(),
      binding: PermissionBinding(),
    ),

     GetPage(
      name: _Paths.ARTISTSONG,
      page: () => ArtistSongsScreen(),
      binding: PermissionBinding(),
    ),
    
     GetPage(
      name: _Paths.ALBUMSONG,
      page: () => AlbumSongsScreen(),
      
     )


  ];
}
