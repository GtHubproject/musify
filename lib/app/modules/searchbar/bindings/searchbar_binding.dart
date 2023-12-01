import 'package:get/get.dart';

import '../controllers/searchbar_controller.dart';

class SearchbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchbarController>(
      () => SearchbarController(),
    );

    Get.lazyPut<SearchbarController>(
      () => SearchbarController(),
    );
  }
}
