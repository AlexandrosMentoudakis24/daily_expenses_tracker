import 'package:daily_expense_tracker/models/transaction.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';

class NewTransactionNotifier extends ChangeNotifier {
  NewTransactionNotifier()
      : newTransaction = Transaction(
          transactionId: "",
          transactionIcon: Icons.local_grocery_store,
          transactionInfo: "",
          transactionType: TransactionType.income,
          amount: 0.0,
        );

  Transaction newTransaction;

  void clearNewTransaction() {
    newTransaction = Transaction(
      transactionId: "",
      transactionIcon: Icons.donut_large,
      transactionInfo: "",
      transactionType: TransactionType.income,
      amount: 0.0,
    );

    notifyListeners();
  }

  void setNewTransactionIcon(IconData newIcon) {
    newTransaction.transactionIcon = newIcon;

    notifyListeners();
  }

  void setNewTransactionInfo(String newTransactionInfo) {
    newTransaction.transactionInfo = newTransactionInfo;

    notifyListeners();
  }

  void setNewTransactionType(TransactionType newTransactionType) {
    newTransaction.transactionType = newTransactionType;

    notifyListeners();
  }

  void setNewTransactionAmount(double newAmmount) {
    newTransaction.amount = newAmmount;

    notifyListeners();
  }
}

final newTransactionProvider =
    ChangeNotifierProvider<NewTransactionNotifier>((ref) {
  return NewTransactionNotifier();
});
