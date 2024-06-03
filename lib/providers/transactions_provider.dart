import 'package:daily_expense_tracker/models/transaction.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';

class TransactionsNotifier extends ChangeNotifier {
  TransactionsNotifier()
      : existingTransactions = [
          Transaction(
            transactionId: '',
            transactionIcon: Icons.local_grocery_store,
            transactionInfo: "Groceries",
            transactionType: TransactionType.expense,
            amount: 100.55,
          ),
          Transaction(
            transactionId: '',
            transactionIcon: Icons.wallet,
            transactionInfo: "Salary",
            transactionType: TransactionType.income,
            amount: 200,
          ),
          Transaction(
            transactionId: '',
            transactionIcon: Icons.local_grocery_store,
            transactionInfo: "Groceries",
            transactionType: TransactionType.expense,
            amount: 100.55,
          ),
          Transaction(
            transactionId: '',
            transactionIcon: Icons.wallet,
            transactionInfo: "Salary",
            transactionType: TransactionType.income,
            amount: 200,
          ),
          Transaction(
            transactionId: '',
            transactionIcon: Icons.local_grocery_store,
            transactionInfo: "Groceries",
            transactionType: TransactionType.expense,
            amount: 100.55,
          ),
          Transaction(
            transactionId: '',
            transactionIcon: Icons.wallet,
            transactionInfo: "Salary",
            transactionType: TransactionType.income,
            amount: 200,
          ),
          Transaction(
            transactionId: '',
            transactionIcon: Icons.local_grocery_store,
            transactionInfo: "Groceries",
            transactionType: TransactionType.expense,
            amount: 100.55,
          ),
          Transaction(
            transactionId: '',
            transactionIcon: Icons.wallet,
            transactionInfo: "Salary",
            transactionType: TransactionType.income,
            amount: 200,
          ),
          Transaction(
            transactionId: '',
            transactionIcon: Icons.local_grocery_store,
            transactionInfo: "Groceries",
            transactionType: TransactionType.expense,
            amount: 100.55,
          ),
          Transaction(
            transactionId: '',
            transactionIcon: Icons.wallet,
            transactionInfo: "Salary",
            transactionType: TransactionType.income,
            amount: 200,
          ),
          Transaction(
            transactionId: '',
            transactionIcon: Icons.local_grocery_store,
            transactionInfo: "Groceries",
            transactionType: TransactionType.expense,
            amount: 100.55,
          ),
          Transaction(
            transactionId: '',
            transactionIcon: Icons.wallet,
            transactionInfo: "Salary",
            transactionType: TransactionType.income,
            amount: 200,
          ),
        ];

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
