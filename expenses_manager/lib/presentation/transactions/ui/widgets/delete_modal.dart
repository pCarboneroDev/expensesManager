import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class DeleteModal extends StatelessWidget {
  const DeleteModal({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: Text('Confirm delete'),
        content: Text('Are you sure you want to delete this transaction"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // Cancelar
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true), // Confirmar
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text('Confirm'),
          ),
        ],
      );
    }

    return AlertDialog(
      title: Text('Confirm delete'),
      content: Text('Are you sure you want to delete this transaction"?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false), // Cancelar
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true), // Confirmar
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          child: Text('Confirm'),
        ),
      ],
    );
  }
}
