import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../controllers/permission_controller.dart';

class PermissionView extends GetView<PermissionController> {
  const PermissionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messenger = ScaffoldMessenger.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Permission Required'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please grant Music Player  File Access to play music.',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Check if the permission has already been granted
                if (await controller.hasPermission()) {
                  Get.offAllNamed('/bottomnavigationbar');
                  debugPrint('Permission Granted');
                } else {
                  // Request permission if not granted
                  PermissionStatus status = await Permission.storage.request();

                  if (status == PermissionStatus.granted) {
                    Get.offAllNamed('/bottomnavigationbar');
                    debugPrint('Permission Granted');
                    // Save the permission status
                    controller.savePermissionStatus(true);
                  } else {
                    debugPrint('Permission Denied');

                    messenger.showSnackBar(SnackBar(
                      content: Text('Cannot access audio'),
                      action: SnackBarAction(
                          label: 'Open App Settings ',
                          onPressed: () {
                            openAppSettings();
                          }),
                    ));
                  }
                }
              },
              child: const Text('Allow'),
            ),
          ],
        ),
      ),
    );
  }
}
