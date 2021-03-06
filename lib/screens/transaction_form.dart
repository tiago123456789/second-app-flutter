import 'package:bytebank/components/failure_dialog.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/components/success_dialog.dart';
import 'package:bytebank/components/transaction_dialog_authentication.dart';
import 'package:bytebank/http/transaction_webclient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;
  final TransactionWebClient client = TransactionWebClient();
  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();

  bool _processing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                child: Progress("Processing transaction..."),
                visible: this._processing,
              ),
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Transfer'),
                    onPressed: () {
                      final double value =
                          double.tryParse(_valueController.text);
                      final transactionCreated =
                          Transaction(value, widget.contact);

                      showDialog(
                          context: context,
                          builder: (contextDialog) =>
                              TransactionDialogAuthentication(
                                onConfirm: (String password) {
                                  this.setState(() {
                                    this._processing = true;
                                  });
                                  widget.client
                                      .create(transactionCreated, password)
                                      .then((transaction) {
                                    if (transaction != null) {
                                      Navigator.pop(context);
                                    }
                                    this.setState(() {
                                      this._processing = true;
                                    });
                                     showDialog(
                                        context: context,
                                        builder: (contextDialog) {
                                          return SuccessDialog("Transaction executed success!!");
                                        });
                                  }).catchError((e) {
                                    showDialog(
                                        context: context,
                                        builder: (contextDialog) {
                                          return FailureDialog(e.message);
                                        });
                                    this.setState(() {
                                      this._processing = true;
                                    });
                                  });
                                },
                              ));
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
