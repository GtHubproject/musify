import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';


// class SearchbarController extends GetxController {
//   //TODO: Implement SearchbarController

//   final count = 0.obs;
//   @override
//   void onInit() {
//     super.onInit();
//   }

//   @override
//   void onReady() {
//     super.onReady();
//   }

//   @override
//   void onClose() {
//     super.onClose();
//   }

//   void increment() => count.value++;
// }

 // Replace with the actual path to your SongModel class


//new ourrr


// class SearchbarController extends GetxController {
//   late AudioPlayer _audioPlayer;
//   RxList<SongModel> searchResults = <SongModel>[].obs;
//   SongModel? currentSong;
  
//   static SearchbarController get to => Get.find<SearchbarController>();

//    @override
//   void onInit() {
//     super.onInit();
//       _audioPlayer = AudioPlayer();
//   }

//   @override
//   void onClose() {
//     _audioPlayer.dispose();
//     super.onClose();
//   }
// }


//modfd


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

  void playSong(SongModel song) async {
    await audioPlayer.stop();
    await audioPlayer.setUrl(song.data);
    await audioPlayer.play();
  }
}