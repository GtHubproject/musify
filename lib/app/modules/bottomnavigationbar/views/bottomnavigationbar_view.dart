import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:musicplayer/app/modules/favourites/views/favourites_view.dart';
import 'package:musicplayer/app/modules/home/views/home_view.dart';
import 'package:musicplayer/app/modules/library/views/library_view.dart';
import 'package:musicplayer/app/modules/profile/views/profile_view.dart';
import 'package:musicplayer/app/modules/searchbar/views/searchbar_view.dart';
import 'package:musicplayer/constants/colors.dart';

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
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: bottomnavigationbarController.selectedIndex.value,
          children: screens,
        ),
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
            () => BottomNavigationBar(backgroundColor: const Color.fromARGB(255, 229, 224, 206),
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
    );
  }
}
