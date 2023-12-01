import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongModelAdapter extends TypeAdapter<SongModel> {
  @override
  final int typeId = 1; // You can choose any positive integer as your type ID

  @override
  SongModel read(BinaryReader reader) {
    final Map<dynamic, dynamic> _info = reader.readMap();
    return SongModel(_info);
  }

  @override
  void write(BinaryWriter writer, SongModel obj) {
    writer.writeMap(obj.getMap);
  }
}
