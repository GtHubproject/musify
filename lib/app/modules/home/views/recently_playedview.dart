// Example of a new screen or widget to display recently played songs
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/app/data/model/song_model.dart';
import 'package:musicplayer/app/modules/library/controllers/tracks_controller.dart';

class RecentlyPlayedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final trackController = Get.find<TrackController>();
    final recentlyPlayed = trackController.recentlyPlayedBox.get('recently_played', defaultValue: Music(songs: []))!;

    return Scaffold(   
      body: recentlyPlayed.songs.isNotEmpty
          ? ListView.builder(
              itemCount: recentlyPlayed.songs.length,
              itemBuilder: (context, index) {
                var song = recentlyPlayed.songs[index];
                return ListTile(
                  title: Text(song.title),
                  subtitle: Text(song.artist ?? "No Artist"),
                  // Add other details or actions as needed
                );
              },
            )
          : Center(child: Text("No recently played songs")),
    );
  }
}