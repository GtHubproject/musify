import 'package:flutter/material.dart';

void showRenameDialog(BuildContext context) {

                showDialog(barrierColor: 
           Colors.white12,
                  context: context,
                  builder: (BuildContext context) {
                    String playlistName = 'Playlist 1'; // Default playlist name

                    return AlertDialog(
                      title: Text('Rename Playlist'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Playlist Name',
                            ),
                            onChanged: (value) {
                              playlistName = value;
                            },
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            print('Renaming playlist to: $playlistName');
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }