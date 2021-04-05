import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SuccessDialog extends StatelessWidget {
  final String message;

  SuccessDialog(this.message);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Successs'),
      content: Text(this.message),
      actions: <Widget>[
        FlatButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
