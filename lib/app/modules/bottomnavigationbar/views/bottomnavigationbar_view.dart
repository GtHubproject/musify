import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:musicplayer/app/modules/bottomnavigationbar/views/miniplayer.dart';
import 'package:musicplayer/app/modules/favourites/views/favourites_view.dart';
import 'package:musicplayer/app/modules/home/views/home_view.dart';
import 'package:musicplayer/app/modules/library/controllers/tracks_controller.dart';
import 'package:musicplayer/app/modules/library/views/library_view.dart';
import 'package:musicplayer/app/modules/profile/views/profile_view.dart';
import 'package:musicplayer/app/modules/searchbar/views/searchbar_view.dart';


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
              bottom: 2, // Adjust the value as needed
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
               //  backgroundColor: const Color.fromARGB(255, 222, 220, 212),
                backgroundColor: Color.fromARGB(255, 242, 234, 190),
                type: BottomNavigationBarType.fixed,
                selectedItemColor:  Color.fromARGB(255, 61, 21, 21),
                unselectedItemColor: Color.fromARGB(255, 252, 250, 250),
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


