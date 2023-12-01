import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:on_audio_query/on_audio_query.dart';


import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class TrackController extends GetxController {
  final OnAudioQuery audioQuery = OnAudioQuery();
  final AudioPlayer audioPlayer = AudioPlayer();

  Future<bool> checkPermission() async {
    var permissionStatus = await audioQuery.permissionsStatus();
    if (permissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return await audioQuery.permissionsRequest();
    }
  }

  Future<List<SongModel>> querySongs() async {
    return audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
  }

  Future<void> playSong(SongModel song) async {
    await audioPlayer.stop();
    await audioPlayer.setUrl(song.data);
    await audioPlayer.play();
  }
}
