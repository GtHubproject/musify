import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'song_model.g.dart';

@HiveType(typeId: 0)
class Music extends HiveObject {
 
  @HiveField(0)
  late List<SongModel> songs;


  Music({
   
    required this.songs,
  }); 
}

