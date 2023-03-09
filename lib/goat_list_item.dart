import 'package:flutter/material.dart';
import 'constants.dart';
import 'goat.dart';
import 'dart:io';

class GoatListItem extends StatelessWidget {
  final Goat goat;
  final VoidCallback onPressedEdit;
  final VoidCallback onPressedDelete;

  const GoatListItem({
    Key? key,
    required this.goat,
    required this.onPressedEdit,
    required this.onPressedDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: Container(
          width: 64,
          height: 64,
          child: goat.image != null
              ? Image.file(
                  File(goat.image! as String),
                  fit: BoxFit.cover,
                )
              : Icon(Icons.image, color: Constants.lightGrey),
        ),
        title: Text(goat.name ?? ''),
        subtitle: Text('${goat.tag}, ${goat.breed}'),
        trailing: IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: Icon(Icons.edit),
                        title: Text('Edit'),
                        onTap: onPressedEdit,
                      ),
                      ListTile(
                        leading: Icon(Icons.delete),
                        title: Text('Delete'),
                        onTap: onPressedDelete,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
