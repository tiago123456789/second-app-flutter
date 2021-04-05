import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FailureDialog extends StatelessWidget {
  final String message;

  FailureDialog(this.message);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Error'),
      content: Text(this.message),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
