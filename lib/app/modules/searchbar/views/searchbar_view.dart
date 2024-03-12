import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:musicplayer/app/modules/bottomnavigationbar/controllers/bottomnavigationbar_controller.dart';
import 'package:musicplayer/app/modules/library/controllers/tracks_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../controllers/searchbar_controller.dart';
class SearchbarView extends GetView<SearchbarController> {

  final BottomnavigationbarController bottomnavigationbarController =
      Get.put(BottomnavigationbarController());

       final TrackController trackController = Get.put(TrackController());
       
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:   Color.fromARGB(255, 63, 29, 29),
        title: TextField(
          onChanged: (query) => controller.performSearch(query),
          decoration: InputDecoration(
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            prefixIcon: Icon(Icons.search),
            hintText: 'Search...',
            hintStyle: TextStyle(color: const Color.fromARGB(255, 235, 228, 228)),
            border: InputBorder.none,
          ),
          style: TextStyle(color: const Color.fromARGB(255, 238, 231, 231)),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Tracks',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Obx(() {
              final searchResults = controller.searchResults;
              final isSearching = controller.isSearching.value;

              if (searchResults.isEmpty && !isSearching) {
                return _buildMessage("No songs available");
              } else if (searchResults.isEmpty) {
                return _buildMessage("No matching tracks found!");
              } else {
                return ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(searchResults[index].title, style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black), ),
                      subtitle: Text(searchResults[index].artist ?? "No Artist", style: TextStyle(
                      fontWeight: FontWeight.w400, color: Colors.black),),
                      leading: QueryArtworkWidget(
                        controller: controller.audioQuery,
                        id: searchResults[index].id,
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: Container(
                    width: 50,
                    height: 50,
                    color: Color.fromARGB(235, 131, 83, 76),
                    child: Icon(Icons.music_note),
                  ),
                      ),
                      onTap: () {
                      bottomnavigationbarController.playSong(searchResults[index]);
                        trackController.addRecentlyPlayed(searchResults[index]); 
                        bottomnavigationbarController.update();
                        },  
                    
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(String message) {
    return Center(child: Text(message));
  }
}