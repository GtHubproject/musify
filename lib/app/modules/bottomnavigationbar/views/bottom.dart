// Assuming you have access to the BottomnavigationbarController instance
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:musicplayer/app/modules/bottomnavigationbar/controllers/bottomnavigationbar_controller.dart';

final bottomnavigationbarController = Get.find<BottomnavigationbarController>();

// Example UI code with buttons for play and pause
class YourUiWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Button to play the audio
        ElevatedButton(
          onPressed: () {
            // Ensure audioPlayer is not null
            if (bottomnavigationbarController.audioPlayer == null) {
              print("AudioPlayer is null!");
              return;
            }

            // Call play
            bottomnavigationbarController.audioPlayer.play();
          },
          child: Text("Play"),
        ),
        // Button to pause the audio
        ElevatedButton(
          onPressed: () {
            // Ensure audioPlayer is not null
            if (bottomnavigationbarController.audioPlayer == null) {
              print("AudioPlayer is null!");
              return;
            }

            // Call pause
            bottomnavigationbarController.audioPlayer.pause();
          },
          child: Text("Pause"),
        ),
      ],
    );
  }
}
