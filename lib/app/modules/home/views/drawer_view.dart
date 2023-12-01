import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DrawerView extends GetView {
  const DrawerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey[200], // Light grey color for the Drawer
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              // decoration: BoxDecoration(
              //   color: Colors.lightBlue, // Light blue color for the header
              // ),
              child: Center(
                child: Text(
                  'Musify',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.timer),
              title: Text('Sleep Timer'),
              tileColor: Color.fromARGB(255, 138, 92, 92), // Grey color for the ListTile
              onTap: () {
                // Handle onTap action for Sleep Timer tile
                // You can put your logic here
              },
            ),
            // Add more ListTiles for other options if needed
          ],
        ),
      ),
    );
  }
}
