import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/folder_controller.dart';

class FolderView extends GetView<FolderController> {
// //-----data---
//   final List<Map<String, String>> folders = [
//     {'name': 'Download', 'location': 'Internal Storage/Download'},
//     {'name': 'Music', 'location': 'Internal Storage/Music'},
//     {'name': 'Whatsapp Audio', 'location': 'Internal Storage/Whatsapp/Audio'},
//     // --data--
//   ];
  FolderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//         appBar: AppBar(
//           title: Text('Folders'),
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ),
//         body: ListView.builder(
//           itemCount: folders.length,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Card(
//                 color: Color.fromARGB(255, 63, 63, 56),
//                 child: ListTile(
//                   leading: Icon(Icons.folder),
//                   title: Text(folders[index]['name']!),
//                   subtitle: Text(folders[index]['location']!),
//                   onTap: () {
//                     Get.toNamed('/download');
//                     // Handle onTap action for each folder if needed
//                     //print('Tapped: ${folders[index]['name']}');
//                   },
//                 ),
//               ),
//             );
//           },
//         )
        );
    //}
  }
}
