import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/app/modules/bottomnavigationbar/controllers/bottomnavigationbar_controller.dart';
import 'package:musicplayer/app/modules/library/controllers/artistandsongcontroller.dart';
import 'package:musicplayer/app/modules/library/controllers/tracks_controller.dart';


class ArtistSongsScreen extends GetView<ArtistSongsController> {
  
  final ArtistSongsController artistSongsController =
      Get.put(ArtistSongsController(Get.find<TrackController>()));



  BottomnavigationbarController bottomnavigationbarController =
      Get.put(BottomnavigationbarController());

    final TrackController trackController = Get.put(TrackController());  

      
  @override
  Widget build(BuildContext context) {
    final String artistName = Get.arguments as String;

    // Load songs by artist when the screen is built
    controller.loadSongsByArtist(artistName);

    return Scaffold(
      appBar: AppBar(
        title: Text('Songs by $artistName'),
      ),
      body: Column(
        children: [
          // Display the query image of the artist
          // QueryArtworkWidget(
          //   controller: Get.find<TrackController>().audioQuery,
          //   artist: artistName,
          //   type: ArtworkType.ARTIST,
          //   nullArtworkWidget: Container(
          //     width: 100,
          //     height: 100,
          //     color: Colors.grey, // Add a default color or placeholder
          //     child: Icon(Icons.person),
          //   ), id: null,
          // ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.songs.length,
                itemBuilder: (context, index) {
                  var song = controller.songs[index];
                  return ListTile(


                    title: Text(song.title,  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),),
                    subtitle: Text(artistName,style: TextStyle(
                      fontWeight: FontWeight.w400, color: Colors.black),),
onTap:(){
   bottomnavigationbarController.playSongFromList(song ,controller.songs);
     // bottomnavigationbarController.setCurrentSong(song);
     bottomnavigationbarController.update();
       trackController.addRecentlyPlayed(song);
    //  trackController.addRecentlyPlayed(song);
},
                      
                    // Add other necessary UI components
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
