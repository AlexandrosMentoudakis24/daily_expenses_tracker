import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:daily_expense_tracker/models/user_account.dart';
import 'package:daily_expense_tracker/models/transaction.dart';

class LoggedUserAccountNotifier extends ChangeNotifier {
  LoggedUserAccountNotifier()
      : loggedAccount = UserAccount(
          accountId: "",
          firstName: "",
          lastName: "",
          age: 0,
          email: "",
          balance: 0.0,
          createdAt: DateTime(0),
        );

  UserAccount loggedAccount;

  void setLoggedAccount(UserAccount newUserAccount) {
    loggedAccount = newUserAccount;

    notifyListeners();
  }

  void clearTransactions() {
    loggedAccount = UserAccount(
      accountId: "",
      firstName: "",
      lastName: "",
      age: 0,
      email: "",
      balance: 0.0,
      createdAt: DateTime(0),
    );

    notifyListeners();
  }

  void completeNewTransaction(Transaction newTransaction) {
    final transactionAmmount = newTransaction.amount;

    try {
      newTransaction.transactionType == TransactionType.expense
          ? loggedAccount.decreaseBalance(transactionAmmount)
          : loggedAccount.increaseBalance(transactionAmmount);
    } catch (err) {
      throw ("Insufficient account balance!");
    }

    notifyListeners();
  }

  void addMoreFunds(double newAddedAmount) {
    loggedAccount.increaseBalance(newAddedAmount);

    notifyListeners();
  }
}

final loggedUserAccountProvider =
    ChangeNotifierProvider<LoggedUserAccountNotifier>((ref) {
  return LoggedUserAccountNotifier();
});
