import 'package:get/get.dart';

// class PermissionController extends GetxController {
//   //TODO: Implement PermissionController

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
import 'package:shared_preferences/shared_preferences.dart';

class PermissionController extends GetxController {
  final String permissionStatusKey = 'audioPermission';

  Future<bool> hasPermission() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(permissionStatusKey) ?? false;
  }

  Future<void> savePermissionStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(permissionStatusKey, status);
  }
}
