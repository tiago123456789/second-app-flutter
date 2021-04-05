import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class TransactionDialogAuthentication extends StatefulWidget {
  final Function(String) onConfirm;

  TransactionDialogAuthentication({
    @required this.onConfirm,
  });

  @override
  TransactionDialogAuthenticationState createState() => TransactionDialogAuthenticationState();
}

class TransactionDialogAuthenticationState extends State<TransactionDialogAuthentication> {

  final passwordInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Authenticate"),
      content: TextField(
        controller: passwordInput,
        keyboardType: TextInputType.number,
        obscureText: true,
        maxLength: 4,
        style: TextStyle(fontSize: 64, letterSpacing: 32),
        textAlign: TextAlign.center,
      ),
      actions: [
        FlatButton(onPressed: () => Navigator.pop(context), 
          child: Text('Cancel')
        ),
        FlatButton(onPressed: () {
          widget.onConfirm(passwordInput.text.toString());
          Navigator.pop(context);
        }, child: Text('Confirm')
        ),
      ],
    );
  }

}