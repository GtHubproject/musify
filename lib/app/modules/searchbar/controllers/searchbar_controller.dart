import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchbarController extends GetxController {
  late AudioPlayer audioPlayer;
  RxList<SongModel> searchResults = <SongModel>[].obs;
  RxBool isSearching = false.obs;
  SongModel? currentSong;
  late OnAudioQuery audioQuery;

  static SearchbarController get to => Get.find<SearchbarController>();

  @override
  void onInit() {
    super.onInit();
    audioPlayer = AudioPlayer();
    audioQuery = OnAudioQuery();
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }

  void performSearch(String query) async {
    final allSongs = await audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    final filteredSongs = allSongs.where(
      (song) =>
          song.title.toLowerCase().contains(query.toLowerCase()) ||
          (song.artist != null && song.artist!.toLowerCase().contains(query.toLowerCase())),
    ).toList();

    searchResults.assignAll(filteredSongs);
    isSearching.value = query.isNotEmpty;
  }


  

 
}