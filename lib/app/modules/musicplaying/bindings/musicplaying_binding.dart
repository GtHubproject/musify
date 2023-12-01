import 'package:get/get.dart';

import '../controllers/musicplaying_controller.dart';

class MusicplayingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MusicplayingController>(
      () => MusicplayingController(),
    );
  }
}
