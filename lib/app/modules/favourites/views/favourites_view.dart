import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/favourites_controller.dart';

class Song {
  final String title;
  final String imageUrl; // Image URL for the song

  Song({required this.title, required this.imageUrl});
}

class FavouritesView extends GetView<FavouritesController> {

  final List<Song> favoriteSongs = [
    Song(title: 'Song 1', imageUrl: ''),
    // 'https://images.unsplash.com/photo-1471478331149-c72f17e33c73?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8bXVzaWMlMjBhcHB8ZW58MHx8MHx8fDA%3D'),
    Song(title: 'Song 2', imageUrl: ''), // Song without image
    // Add more songs as needed
  ];

   FavouritesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView.builder(
        itemCount: favoriteSongs.length,
        itemBuilder: (context, index) {
          return ListTile(
          
            tileColor: Color.fromARGB(255, 199, 187, 148),
            leading: favoriteSongs[index].imageUrl != ''
                ? Image.network(
                    favoriteSongs[index].imageUrl,
                    width: 50, // Adjust size as needed
                    height: 50,
                  )
                : Icon(Icons.music_note), // Default icon if no image is available
            title: Text(favoriteSongs[index].title,style: TextStyle(color: Colors.black),),
            trailing: IconButton( icon:Icon(Icons.favorite), onPressed: () {  },), // Heart icon as trailing widget
            onTap: () {
              // Add functionality for when a song tile is tapped
              print('Song tapped: ${favoriteSongs[index].title}');
            },
          );
        },
      ),
    );
  }
}
