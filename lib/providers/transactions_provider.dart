import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import 'package:daily_expense_tracker/utils/constants/web_server_uri_constants.dart';
import 'package:daily_expense_tracker/models/transaction.dart';

class TransactionsNotifier extends ChangeNotifier {
  TransactionsNotifier() : existingTransactions = [];

  List<Transaction> existingTransactions;

  void setTransactions(List<Transaction> newTransactions) {
    existingTransactions = [...newTransactions];

    notifyListeners();
  }

  void clearTransactions() {
    existingTransactions = [];

    notifyListeners();
  }

  void addNewTransaction(Transaction newTransaction) {
    existingTransactions = [newTransaction, ...existingTransactions];

    notifyListeners();
  }

  Future<void> fetchAllTransactions() async {
    final dio = Dio();

    try {
      final response = await dio.get(
        "${WebServer.serverUri}/transactions",
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Error();
      }

      final responseData = response.data;

      final fetchedTransactions = responseData["transactions"];

      final formattedFetchedTransactions = Transaction.formatAll(
        [...fetchedTransactions],
      );

      existingTransactions = [...formattedFetchedTransactions];

      notifyListeners();
    } catch (err) {
      throw "Failed to fetch data!";
    }
  }

  Future<bool> deleteSingleTransaction({
    required String transactionId,
  }) async {
    final dio = Dio();

    try {
      final response = await dio.delete(
        "${WebServer.serverUri}/transactions/deleteTransaction/$transactionId",
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Error();
      }

      existingTransactions = [
        ...existingTransactions.where(
          (t) => t.transactionId != transactionId,
        ),
      ];

      notifyListeners();

      return true;
    } catch (err) {
      return false;
    }
  }
}

final transactionsProvider =
    ChangeNotifierProvider<TransactionsNotifier>((ref) {
  return TransactionsNotifier();
});
