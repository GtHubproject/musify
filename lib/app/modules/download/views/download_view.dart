import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/download_controller.dart';

class DownloadView extends GetView<DownloadController> {

  final List<Map<String, String>> downloadedSongs = [
    {
      'title': 'Song 1',
      'artist': 'Artist 1',
      'imageUrl': 'URL for Image 1',
    },
    {
      'title': 'Song 2',
      'artist': 'Artist 2',
      'imageUrl': 'URL for Image 2',
    },
    // Add more downloaded songs as needed
  ];
   DownloadView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Download'),
      ),
      body: ListView.builder(
        itemCount: downloadedSongs.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(downloadedSongs[index]['imageUrl'] ?? ''),
            ),
            title: Text(downloadedSongs[index]['title'] ?? ''),
            subtitle: Text(downloadedSongs[index]['artist'] ?? ''),
            trailing: PopupMenuButton(
              icon: Icon(Icons.more_vert), // Three-dot icon
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry>[
                  PopupMenuItem(
                    child: Text('Option 1'),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: Text('Option 2'),
                    value: 2,
                  ),
                  // Add more options if needed
                ];
              },
            ),
            onTap: () {
              // Handle onTap action for each downloaded song if needed
              print('Tapped: ${downloadedSongs[index]['title']}');
            },
          );
        },
      ),
    );
  }
}
