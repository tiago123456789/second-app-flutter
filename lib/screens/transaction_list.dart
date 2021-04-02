import 'package:bytebank/components/centered_message.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/http/transaction_webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions = List();
  final TransactionWebClient client = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: Future.delayed(Duration(seconds: 1)).then((value) => client.findAll()),
        builder: (context, snapshot) {
          final List<Transaction> transactions = snapshot.data;
          switch(snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
            if (transactions.isEmpty) {
              return CenteredMessage(
                "Not transaction found!!!",
                icon: Icons.warning
              );
            }
            return ListView.builder(
                itemBuilder: (context, index) {
                  final Transaction transaction = transactions[index];
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.monetization_on),
                      title: Text(
                        transaction.value.toString(),
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        transaction.contact.accountNumber.toString(),
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: transactions.length,
              );
              break;
          }
        }
      )
    );
  }
}
