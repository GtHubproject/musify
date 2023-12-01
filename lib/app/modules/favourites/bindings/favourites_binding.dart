import 'package:get/get.dart';

import '../controllers/favourites_controller.dart';

class FavouritesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavouritesController>(
      () => FavouritesController(),
    );
  }
}
