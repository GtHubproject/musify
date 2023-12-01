import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/musicplaying_controller.dart';

class MusicplayingView extends GetView<MusicplayingController> {
  MusicplayingView({Key? key}) : super(key: key);

    final MusicplayingController controller = Get.put(MusicplayingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 15.0, left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //1
              SizedBox(
                width: 200,
                height: 200,
                child: Image.asset(
                  'assets/folder1.jpeg',
                  height: 200,
                  width: 100,
                ), // Placeholder for album artwork
              ),
              const SizedBox(height: 20),
              //2
              const Text(
                'Song Title',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              //3
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {
                      // Functionality to add/remove from favorites
                    },
                  ),
                  const Text(
                    'Artist Name',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: 40,
                  )
                ],
              ),

              const SizedBox(height: 10),

              //4
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Slider(
                        activeColor: Colors.amber,
                        value: 0.3, // Change this value based on song progress
                        onChanged: (double value) {
                          // Change the song's progress
                        },
                      ),
                    ),
                    // Replace with actual song position
                  ],
                ),
              ),
              //5
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('0:00'),
                  Text('0:00'),
                ],
              ),
              const SizedBox(height: 40),
              // 6 -music playing
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.skip_previous),
                      iconSize: 40,
                      onPressed: () {
                        // Functionality for previous song
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.togglePlaying();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Obx(() => IconButton(
                            icon: Icon(
                                controller.isPlaying.value
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.black),
                            iconSize: 60,
                            onPressed: () {
                              // Functionality for play/pause
                            },
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.skip_next),
                      iconSize: 40,
                      onPressed: () {
                        // Functionality for next song
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
