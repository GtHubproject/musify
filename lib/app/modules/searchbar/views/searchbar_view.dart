import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../controllers/searchbar_controller.dart';

// class SearchbarView extends GetView<SearchbarController> {
//   const SearchbarView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: TextField(
          
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
//             child: ListView.builder(
//               itemCount: 10, 
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text('Track $index'),
//                   leading: Icon(Icons.music_note), // Replace with your song icon
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SearchbarController extends GetxController {
//   RxList<SongModel> searchResults = <SongModel>[].obs;
// }

//aa


// class SearchbarView extends GetView<SearchbarController> {
//   final OnAudioQuery _audioQuery = OnAudioQuery();

//   @override
//   Widget build(BuildContext context) {
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
//           return Center(child: Text("No matching tracks found!"));
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
//                 // Add your desired actions or UI elements here
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
// }


//bb original

//class SearchbarView extends GetView<SearchbarController> {
//   final OnAudioQuery _audioQuery = OnAudioQuery();
//   late AudioPlayer _audioPlayer;

//   @override
//   Widget build(BuildContext context) {
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
//           return Center(child: Text("No matching tracks found!"));
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
//                 trailing: IconButton(
//                   icon: Icon(Icons.play_arrow),
//                   onPressed: () {
//                     _playSong(searchResults[index]);
//                   },
//                 ),
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


//new
// searchbar_view.dart



// class SearchbarView extends GetView<SearchbarController> {
//   final OnAudioQuery _audioQuery = OnAudioQuery();
//    AudioPlayer _audioPlayer=AudioPlayer();
//   SongModel? currentSong;

//   @override
//   Widget build(BuildContext context) {
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
//           _buildBottomMediaBar(),
//         ],
//       ),
//     );
//   }

//   Widget _buildSearchResults() {
//     return Obx(
//       () {
//         final searchResults = controller.searchResults;
//         if (searchResults.isEmpty) {
//           return Center(child: Text("No matching tracks found!"));
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
//                 trailing: IconButton(
//                   icon: Icon(Icons.play_arrow),
//                   onPressed: () {
//                     _playSong(searchResults[index]);
//                   },
//                 ),
//               );
//             },
//           );
//         }
//       },
//     );
//   }

//   Widget _buildBottomMediaBar() {
//     return GetBuilder<SearchbarController>(
//       builder: (controller) {
//         return Visibility(
//           visible: _audioPlayer.playing,
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 5,
//                   blurRadius: 7,
//                   offset: const Offset(0, -3),
//                 ),
//               ],
//             ),
//             padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 QueryArtworkWidget(
//                   controller: _audioQuery,
//                   id: controller.currentSong!.id,
//                   type: ArtworkType.AUDIO,
//                 ),
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       controller.currentSong?.title ?? "",
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       controller.currentSong?.artist ?? "No Artist",
//                       style: TextStyle(fontSize: 14),
//                     ),
//                   ],
//                 ),
//                 IconButton(
//                   icon: Icon(_audioPlayer.playing ? Icons.pause : Icons.play_arrow),
//                   onPressed: () {
//                     _audioPlayer.playing ? _audioPlayer.pause() : _audioPlayer.play();
//                     controller.update();
//                   },
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.skip_next),
//                   onPressed: () {
//                     // Logic to skip to the next track
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
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
//     controller.currentSong = song;
//     controller.update();
//   }
// }



class SearchbarView extends GetView<SearchbarController> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  late AudioPlayer _audioPlayer;

  @override
  Widget build(BuildContext context) {
    _audioPlayer = Get.find<AudioPlayer>(); // Assuming you registered AudioPlayer with Get.put().

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (query) => _performSearch(query),
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
            child: _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return Obx(
      () {
        final searchResults = controller.searchResults;
        if (searchResults.isEmpty) {
          return Center(child: Text("No matching tracks found!"));
        } else {
          return ListView.builder(
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(searchResults[index].title),
                subtitle: Text(searchResults[index].artist ?? "No Artist"),
                leading: QueryArtworkWidget(
                  controller: _audioQuery,
                  id: searchResults[index].id,
                  type: ArtworkType.AUDIO,
                ),
                onTap: () {
                  _playSong(searchResults[index]);
                },
              );
            },
          );
        }
      },
    );
  }

  void _performSearch(String query) async {
    final allSongs = await _audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    final filteredSongs = allSongs.where(
      (song) =>
          song.title.toLowerCase().contains(query.toLowerCase()) ||
          (song.artist != null && song.artist!.toLowerCase().contains(query.toLowerCase())),
    ).toList();

    controller.searchResults.assignAll(filteredSongs);
  }

  void _playSong(SongModel song) async {
    await _audioPlayer.stop();
    await _audioPlayer.setUrl(song.data);
    await _audioPlayer.play();
  }
}
