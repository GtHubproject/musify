import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/app/modules/bottomnavigationbar/controllers/bottomnavigationbar_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../controllers/searchbar_controller.dart';


///////new ourssss

// class SearchbarView extends GetView<SearchbarController> {
//   final OnAudioQuery _audioQuery = OnAudioQuery();
//   late AudioPlayer _audioPlayer;

//   @override
//   Widget build(BuildContext context) {
//     _audioPlayer = Get.find<AudioPlayer>(); // Assuming you registered AudioPlayer with Get.put().

//     return Scaffold(
//       appBar: AppBar(
//         title: TextField(
//           onChanged: (query) => _performSearch(query),
//           decoration: InputDecoration(
//             focusedBorder: InputBorder.none,
//             enabledBorder: InputBorder.none,
//             prefixIcon: Icon(Icons.search),
//             hintText: 'Search...',
//             hintStyle: TextStyle(color: const Color.fromARGB(255, 235, 228, 228)),
//             border: InputBorder.none,
//           ),
//           style: TextStyle(color: const Color.fromARGB(255, 238, 231, 231)),
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               'Tracks',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Expanded(
//             child: _buildSearchResults(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSearchResults() {
//     return Obx(
//       () {
//         final searchResults = controller.searchResults;
//         if (searchResults.isEmpty) {
//           return Center(child: Text("No matching tracks found!a"));
//         } else {
//           return ListView.builder(
//             itemCount: searchResults.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(searchResults[index].title),
//                 subtitle: Text(searchResults[index].artist ?? "No Artist"),
//                 leading: QueryArtworkWidget(
//                   controller: _audioQuery,
//                   id: searchResults[index].id,
//                   type: ArtworkType.AUDIO,
//                 ),
//                 onTap: () {
//                   _playSong(searchResults[index]);
//                 },
//               );
//             },
//           );
//         }
//       },
//     );
//   }

//   void _performSearch(String query) async {
//     final allSongs = await _audioQuery.querySongs(
//       sortType: null,
//       orderType: OrderType.ASC_OR_SMALLER,
//       uriType: UriType.EXTERNAL,
//       ignoreCase: true,
//     );

//     final filteredSongs = allSongs.where(
//       (song) =>
//           song.title.toLowerCase().contains(query.toLowerCase()) ||
//           (song.artist != null && song.artist!.toLowerCase().contains(query.toLowerCase())),
//     ).toList();

//     controller.searchResults.assignAll(filteredSongs);
//   }

//   void _playSong(SongModel song) async {
//     await _audioPlayer.stop();
//     await _audioPlayer.setUrl(song.data);
//     await _audioPlayer.play();
//   }
// }



 //modfd
 
class SearchbarView extends GetView<SearchbarController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                      title: Text(searchResults[index].title),
                      subtitle: Text(searchResults[index].artist ?? "No Artist"),
                      leading: QueryArtworkWidget(
                        controller: controller.audioQuery,
                        id: searchResults[index].id,
                        type: ArtworkType.AUDIO,
                      ),
                      onTap: () {
                         controller.playSong(searchResults[index]); // Play the tapped song
                    // Additionally, you may want to update the MiniPlayer in your bottom navigation bar
                    // You can do this by updating the BottomnavigationbarController's currentSong
                    Get.find<BottomnavigationbarController>().setCurrentSong(searchResults[index]);
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