// Example of a new screen or widget to display recently played songs
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/app/data/model/song_model.dart';
import 'package:musicplayer/app/modules/library/controllers/tracks_controller.dart';
import 'package:musicplayer/app/modules/bottomnavigationbar/controllers/bottomnavigationbar_controller.dart';

class RecentlyPlayedScreen extends StatelessWidget {
  BottomnavigationbarController bottomnavigationbarController =
      Get.put(BottomnavigationbarController());




  @override
  Widget build(BuildContext context) {
    final trackController = Get.find<TrackController>();

    final recentlyPlayed = trackController.recentlyPlayedBox
        .get('recently_played', defaultValue: Music(songs: []))!;

    return Scaffold(
      body: recentlyPlayed.songs.isNotEmpty
          ? ListView.builder(
              itemCount: recentlyPlayed.songs.length,
              itemBuilder: (context, index) {
                var song = recentlyPlayed.songs[index];
                return ListTile(
                    title: Text(
                      song.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 37, 37, 36)),
                    ),
                    subtitle: Text(
                      song.artist ?? "No Artist",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: const Color.fromARGB(255, 28, 27, 27)),
                    ),
                    onTap: () {
                    
                     bottomnavigationbarController.playSongFromList(song, recentlyPlayed.songs);
                    }
                    );
              },
            )
          : Center(child: Text("Waiting For Making a \nDecent Recent Collection",style: TextStyle(color: const Color.fromARGB(255, 176, 150, 71),fontSize: 18,fontWeight: FontWeight.bold),)),
    );

    
  }
}
