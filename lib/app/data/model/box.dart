import 'package:hive/hive.dart';
import 'package:musicplayer/app/data/model/song_model.dart';

class Boxes{
  static Box<Playlist> getPlaylist()=> Hive.box<Playlist>('playlistbox');

}
