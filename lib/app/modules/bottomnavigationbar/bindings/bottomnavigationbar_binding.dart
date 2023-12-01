import 'package:get/get.dart';

import '../controllers/bottomnavigationbar_controller.dart';

class BottomnavigationbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomnavigationbarController>(
      () => BottomnavigationbarController(),
    );
  }
}
