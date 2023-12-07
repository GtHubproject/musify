import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:musicplayer/app/modules/favourites/views/favourites_view.dart';
import 'package:musicplayer/app/modules/home/views/home_view.dart';
import 'package:musicplayer/app/modules/library/controllers/tracks_controller.dart';
import 'package:musicplayer/app/modules/library/views/library_view.dart';
import 'package:musicplayer/app/modules/profile/views/profile_view.dart';
import 'package:musicplayer/app/modules/searchbar/views/searchbar_view.dart';
import 'package:musicplayer/constants/colors.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../controllers/bottomnavigationbar_controller.dart';

class BottomnavigationbarView extends GetView<BottomnavigationbarController> {
  final currentIndex = 0.obs; // Set initial index

  BottomnavigationbarController bottomnavigationbarController =
      Get.put(BottomnavigationbarController());
  BottomnavigationbarView({Key? key}) : super(key: key);

  final screens = [
    HomeView(),
    SearchbarView(),
    const LibraryView(),
    FavouritesView(),
    //const ProfileView(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Obx(
              () => IndexedStack(
                index: bottomnavigationbarController.selectedIndex.value,
                children: screens,
              ),
            ),
            Positioned(
              bottom: 4, // Adjust the value as needed
              left: 0,
              right: 0,
              child: MiniPlayer(),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            //color: const Color.fromARGB(255, 235, 225, 225), // Set the background color
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Obx(
              () => BottomNavigationBar(
                backgroundColor: const Color.fromARGB(255, 222, 220, 212),
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Color.fromARGB(255, 80, 76, 24),
                unselectedItemColor: Color.fromARGB(255, 15, 15, 15),
                showSelectedLabels: true,
                showUnselectedLabels: false,
                onTap: (index) {
                  bottomnavigationbarController.changeIndex(index);
                },
                currentIndex: bottomnavigationbarController.selectedIndex.value,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search_outlined),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.library_music_outlined),
                    label: 'Library',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border_outlined),
                    label: 'favourites',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MiniPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BottomnavigationbarController bottomController = Get.find();
    final trackController = Get.find<TrackController>();
    final currentSong = bottomController.currentSong.value;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            Get.toNamed('/fullsongview');
          },
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 237, 96, 31),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    currentSong != null
                        ? QueryArtworkWidget(
                            controller: trackController.audioQuery,
                            id: currentSong.id,
                            type: ArtworkType.AUDIO,
                          )
                        : Container(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                            child: Marquee(
                              text: currentSong != null
                                  ? 'Now Playing: ${currentSong.title}'
                                  : 'No song playing',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            currentSong != null
                                ? 'Artist: ${currentSong.artist ?? "Unknown"}'
                                : '',
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(bottomController.audioPlayer.playing
                          ? Icons.pause
                          : Icons.play_arrow),
                      onPressed: () {
                        if (bottomController.audioPlayer.playing) {
                          bottomController.pauseSong();
                        } else {
                          bottomController.audioPlayer.play();
                        }
                        bottomController.update();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.stop),
                      onPressed: () {
                        bottomController.stopSong();
                        bottomController.update();
                      },
                    ),
                  ],
                ),
                Expanded(
                  flex: 2,
                  child: currentSong != null
                      ? LinearProgressIndicator(
                          value: currentSong.duration?.toDouble() ?? 0.0,
                          backgroundColor: Colors.grey,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(255, 213, 199, 199),
                          ),
                          minHeight: 0.001,
                        )
                      : Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
