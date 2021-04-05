import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Progress extends StatelessWidget {
  String _message = "Loading";

  Progress(this._message);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: 
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(this._message),
                        )
                      ],
                    ),
                  ),
                
      );
  }
}
