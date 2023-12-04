import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:musicplayer/app/common/widget.dart';
import 'package:musicplayer/app/data/model/box.dart';
import 'package:musicplayer/app/data/model/song_model.dart';
import 'package:musicplayer/app/modules/home/views/drawer_view.dart';
import 'package:musicplayer/app/modules/home/widget/addnew_playlist.dart';
//import 'package:musicplayer/app/modules/home/views/bottom_navbar_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
   final HomeController controller = Get.find<HomeController>();
  HomeView({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color.fromARGB(255, 19, 18, 18),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,

        //   backgroundColor: Color.fromARGB(255, 247, 230, 245),
        // backgroundColor: Colors.transparent,
        title: const Text(
          'MUSIFY',
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        //backgroundColor: const Color.fromARGB(255, 19, 18, 18), // App bar background color
      ),

      //  drawer:DrawerView(),
      //bottomNavigationBar: const CustomNavbar(),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.toNamed('/folder');
                        },
                        child: Image.asset(
                          'assets/folder.jpeg',
                          height: 100,
                          width: 200,
                        )),
                    CustomSizedBox(),
                    const Text('FOLDER'),
                  ],
                ),
              ],
            ),
          ),

          // ----Main Title: Playlists-----

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Playlists',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                IconButton(
  icon: const Icon(Icons.add_circle, size: 50, color: Colors.white),
  onPressed: () async {
    // Show a dialog to get the playlist name
   // String? playlistName = await _getPlaylistNameDialog(context);

   // if (playlistName != null && playlistName.isNotEmpty) {
      // Create the playlist
      showCreatePlaylistDialog(context);
   // }
  },
),

//                IconButton(
//   icon: const Icon(
//     Icons.add_circle,
//     size: 50,
//     color: Colors.white,
//   ),
//   onPressed: () {
//     showDialog(
//       context: context,
//       builder: (context) {
//         String playlistName = '';
//         return AlertDialog(
//           title: Text('Create Playlist'),
//           content: TextField(
//             onChanged: (value) => playlistName = value,
//             decoration: InputDecoration(labelText: 'Playlist Name'),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 // Add your validation if needed
//                 controller.createPlaylist(playlistName, []);
//                 Navigator.pop(context);
//               },
//               child: Text('Create'),
//             ),
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('Cancel'),
//             ),
//           ],
//         );
//       },
//     );
//   },
// ),

              ],
              // Future createPlaylist(String playlistname){

              // }
            ),
          ),




//playlist display


// Playlist display
  Expanded(
    child: ValueListenableBuilder(
      valueListenable: controller.musicBox.listenable(),
      builder: (context, musicBox, child) {
        return SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: musicBox.length,
            itemBuilder: (context, index) {
              String playlistName = musicBox.keyAt(index);

              // Retrieve the playlist from the box, handle null case
              Music? playlistNullable = musicBox.get(playlistName);
              Music playlist = playlistNullable ?? Music(songs: []);

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigate to the PlaylistDisplayView with the selected playlist name
                        Get.toNamed('/playlistsdetail', arguments: {'playlistName': playlistName});
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset('assets/images.jpeg', height: 100, width: 150),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      playlistName,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    ),
  ),



        // Expanded(
        //     child: ValueListenableBuilder(
        //       valueListenable: controller.musicBox.listenable(),
        //       builder: (context, Box<Music> box, _) {
        //         return SizedBox( height: 100,
        //           child: ListView.builder(
        //             scrollDirection: Axis.horizontal,
        //             itemCount: box.length,
        //             itemBuilder: (context, index) {
        //               final playlistName = box.keyAt(index);

        //                 return Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.center,
        //                   children: [
        //                     GestureDetector(
        //                       onTap: () {

                                  

        //                         Get.toNamed('/playlistsdetail',parameters: {'playlistName': playlistName});
        //                       },
        //                       child: ClipRRect(
        //                         borderRadius: BorderRadius.circular(12),
        //                         child: Image.asset('assets/images.jpeg',
        //                             height: 100, width: 150),
        //                       ),
        //                     ),
        //                     const SizedBox(height: 8),
        //                     Text(
        //                       playlistName,  
        //                       style: TextStyle(fontSize: 16),
        //                     ),
        //                   ],
        //                 ),
        //               );
                     
        //             },
        //           ),
        //         );
        //       },
        //     ),
        //   ),

          

          //----Recently played--- //

          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Recently Played',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),

          // List of Recently Played Songs
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Replace with your number of recently played songs
              itemBuilder: (context, index) {
                return ListTile(
                  leading: GestureDetector(
                    onTap: () {
                      Get.toNamed('/musicplaying');
                    },
                    child: Image.asset(
                      'assets/folder1.jpeg', // Replace with your song image asset
                      width: 50,
                      height: 50,
                    ),
                  ),
                  title: const Text('song'), // Replace with your song title
                  subtitle:
                      const Text('party song'), // Replace with your artist name
                  // Add more song details or onTap functionality as needed
                );
              },
            ),
          ),
        ],
      ),
    ); //future
  }



 Future<void> showCreatePlaylistDialog(BuildContext context) async {
    String playlistName = "";
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Create Playlist"),
          content: TextField(
            onChanged: (value) {
              playlistName = value;
            },
            decoration: InputDecoration(labelText: "Playlist Name"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (playlistName.isNotEmpty) {
                  await controller.createPlaylist(playlistName);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }

}

//playlistDialog


// class PlaylistDialog extends StatefulWidget {
//   @override
//   _PlaylistDialogState createState() => _PlaylistDialogState();
// }

// class _PlaylistDialogState extends State<PlaylistDialog> {
//   TextEditingController playlistController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Create Playlist'),
//       content: TextField(
//         controller: playlistController,
//         decoration: InputDecoration(labelText: 'Playlist Name'),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: Text('Cancel'),
//         ),
//         TextButton(
//           onPressed: () {
//             // Create or update the playlist
//             _createOrUpdatePlaylist(playlistController.text);
//             Navigator.pop(context);
//           },
//           child: Text('Create'),
//         ),
//       ],
//     );
//   }

//   void _createOrUpdatePlaylist(String playlistName) {
//     // Open the Hive box for playlists
//     var playlistBox = Hive.box('playlists');

//     // Check if the playlist name already exists
//     if (playlistBox.containsKey(playlistName)) {
//       // Playlist already exists, you can add your update logic here if needed
//       print('Playlist already exists');
//     } else {
//       // Playlist does not exist, create a new one
//       playlistBox.put(playlistName, []);
//       // Show the playlist dialog by passing the playlistName as a parameter
//       showPlaylistDialog(playlistName);
//     }
//   }

//   void showPlaylistDialog(String playlistName) {
//     // Implement your logic to display the created or updated playlist
//     // You can use Get.toNamed('/playlistsdetail', arguments: playlistName);
//     // or any other method to navigate or show the playlist details.
//   }
// }


