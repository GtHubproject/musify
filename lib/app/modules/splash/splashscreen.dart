import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:musicplayer/app/modules/permission/controllers/permission_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    super.initState();
    checkPermissionAndNavigate();
  }

  Future<void> checkPermissionAndNavigate() async {
    bool hasPermission = await PermissionController().hasPermission();
    
    // Wait for 2 seconds
    await Future.delayed(Duration(seconds: 2));

    if (hasPermission) {
      // Permission already granted, navigate to the desired screen
      Get.offNamed('/bottomnavigationbar');
    } else {
      // Permission not granted, navigate to the permission screen
      Get.offNamed('/permission');
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/music icon.png',
          width: media.width * 0.34,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
