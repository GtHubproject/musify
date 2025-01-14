import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:musicplayer/app/modules/library/views/artist_view.dart';
import 'package:musicplayer/app/modules/library/views/tracks_view.dart';
import '../controllers/library_controller.dart';

class LibraryView extends GetView<LibraryController> {
  const LibraryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(centerTitle: true,
        backgroundColor:  Color.fromARGB(255, 63, 29, 29),
          title: Text('Library'),
          bottom: TabBar(
            indicatorColor: const Color.fromARGB(255, 253, 242, 139),
            labelColor: const Color.fromARGB(255, 253, 242, 139),
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(text: 'Tracks'),
              Tab(text: 'Artists'),
             // Tab(text: 'Albums'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTracks(), // Using the TracksView widget
            _buildArtists(), // Using the ArtistsView widget
         
          ],
        ),
      ),
    );
  }

  Widget _buildTracks() {
    return TracksView();
  }

  Widget _buildArtists() {
    return ArtistsView();
  }

  // Widget _buildAlbums() {
  //   return AlbumsView();
  // }
}
