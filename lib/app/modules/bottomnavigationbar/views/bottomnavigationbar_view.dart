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
              child: YourWidgetAboveBottomNav(),
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

class YourWidgetAboveBottomNav extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    // Your widget content goes here
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        
        height: 70,
        decoration: BoxDecoration(
           color: Color.fromARGB(255, 237, 96, 31), // Set the color as needed
          // boxShadow: [
          //   BoxShadow(
              // color: Colors.grey.withOpacity(0.5),
              // spreadRadius: 5,
              // blurRadius: 7,
              //  offset: const Offset(0, 10),
          //   ),
          // ],
        ), 
         padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // QueryArtworkWidget(
          // //  controller: controller.audioQuery,
          
          //   type: ArtworkType.AUDIO, id: ,
          // ),
          SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                "song",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  " Artist",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.0),
          IconButton(
            icon: Icon(
              Icons.pause,
            ),
            onPressed: () {
            
            },
          ),
          IconButton(
            icon: const Icon(Icons.skip_next),
            onPressed: () {
              // Logic to skip to the next track
             
            },
          ),
        ],
      ),
      
      ),
    );
  } 
}