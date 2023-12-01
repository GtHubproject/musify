import 'package:flutter/material.dart';

void showDeleteDialog(BuildContext context) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Delete'),
                      content: Text('Are you sure to delete?'),
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
                            // Handle deletion logic here
                            print('Deleting...');
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }