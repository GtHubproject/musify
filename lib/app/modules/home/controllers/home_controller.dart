import 'package:get/get.dart';
import 'package:hive/hive.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
       Hive.box('playlistbox').close();
    super.onClose();
  }

  void increment() => count.value++;
}
