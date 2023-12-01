import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);

    Future.delayed(Duration(seconds: 2), () {
      // Navigate to the HomeView when the delay is complete.
      Get.offNamed('/bottomnavigationbar');
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images.png',width:media.width*0.34,
          fit: BoxFit.cover,
          //width: double.maxFinite,
        ),
      ),
    );
  }
}
