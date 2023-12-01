import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(padding: const EdgeInsets.only(left: 90,top: 40),
        child: Column(
         
          children: [
            const CircleAvatar(
              radius: 50,
           
            ),
            const SizedBox(height: 20),
            const Text(
              'User Name',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            const Text(
              'useremail@example.com',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                
              },
              child: const Text('Logout',),
            ),
          ],
        ),
      ),
    );
  }
}
