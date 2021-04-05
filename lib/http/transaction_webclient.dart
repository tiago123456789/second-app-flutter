import 'dart:convert';
import 'package:bytebank/http/interceptors/logging_interceptor.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:bytebank/utils/constants.dart' as Constants;

class TransactionWebClient {

  final http.Client _client = HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);

  List<Transaction> _mapJsonToListEntity(String body) {
    List<dynamic> content = jsonDecode(body);
        List<Transaction> transactions = List();
        for (Map<String, dynamic> element in content) {
          transactions.add(Transaction.fromJson(element));
        }
    return transactions;
  }

  Future<List<Transaction>> findAll() async {
    final http.Response response =
        await this._client.get(Uri.https(Constants.BASE_URL, 'transactions'));
    return this._mapJsonToListEntity(response.body);
  }

  Future<Transaction> create(Transaction transaction, String password) async {
      final http.Response response =
          await this._client.post(Uri.https(Constants.BASE_URL, 'transactions'),
              headers: {
                "Content-Type":"application/json",
                "password": password,
              },
              body: jsonEncode(transaction.toJson()));
        
      if (response.statusCode == 400) {
        throw Exception('there was an error');
      }

      if (response.statusCode == 401) {
        throw Exception('authentication failed');
      }

      final Map<String, dynamic> transactionCreated = jsonDecode(response.body);
      return Transaction.fromJson(transactionCreated);
    }

}

