import 'package:get/get.dart';
import 'package:musicplayer/app/modules/playlists/controllers/playlist_selection_controller_controller.dart';
import '../controllers/playlists_controller.dart';

class PlaylistsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlaylistSelectionController>(
      () => PlaylistSelectionController(),
    );
    Get.lazyPut<PlaylistDisplayController>(
      () => PlaylistDisplayController(),
    );
  }
}
