import 'package:daily_expense_tracker/models/transaction.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';

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
}

final transactionsProvider =
    ChangeNotifierProvider<TransactionsNotifier>((ref) {
  return TransactionsNotifier();
});
