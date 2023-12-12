import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:marquee/marquee.dart';
import 'package:musicplayer/app/modules/bottomnavigationbar/controllers/bottomnavigationbar_controller.dart';
import 'package:musicplayer/app/modules/library/controllers/tracks_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MiniPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BottomnavigationbarController bottomController = Get.find();
    final trackController = Get.find<TrackController>();
    //final currentSong = bottomController.currentSong.value;

    return GetBuilder<BottomnavigationbarController>(
      builder: (controller) {
        final currentSong = controller.currentSong.value; // Extract currentSong

        if (currentSong == null) {
          // If no song is playing, return an empty container (or null)
          return Container();
        }

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
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color.fromARGB(255, 45, 31, 31),
                  //color: Color.fromARGB(235, 131, 83, 76)
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
                                nullArtworkWidget: Container(
                                  width: 50,
                                  height: 42,
                                  color: Color.fromARGB(235, 131, 83, 76),
                                  child: Icon(Icons.music_note),
                                ),
                              )
                            : Container(),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //
                              SizedBox(
                                height: 20,
                                child: Marquee(
                                  text: currentSong != null
                                      ? 'Now Playing: ${currentSong.title}'
                                      : 'No song playing',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber[200]),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Marquee(
                                  text: currentSong != null
                                      ? 'Artist: ${currentSong.artist ?? "Unknown"}'
                                      : '',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.amber[200]),
                                ),
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
                          icon: Icon(Icons.skip_next),
                          onPressed: () {
                            // Implement logic to play the next song
                            controller.playNextSong();
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
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
