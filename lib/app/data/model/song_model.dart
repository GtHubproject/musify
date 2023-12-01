import 'package:hive/hive.dart';

part 'song_model.g.dart';

// @HiveType(typeId: 0)
// class PlaylistModel extends HiveObject {
//   @HiveField(0)
//    String playlistName;

//   @HiveField(1)
//   List<String> songPaths;

//   PlaylistModel({required this.playlistName, required this.songPaths});

//   void addAll(List<String> tracks) {
//     songPaths.addAll(tracks);
//   }
// }

//create model

@HiveType(typeId: 0)
class Playlist extends HiveObject  {

@HiveField(0)
late String playlistName;

@HiveField(1)
   List<String> songPaths;


  Playlist({required this.playlistName, required this.songPaths});

}



