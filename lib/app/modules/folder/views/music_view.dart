import 'package:flutter/material.dart';

import 'package:get/get.dart';

class MusicView extends GetView {
  const MusicView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MusicView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MusicView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
