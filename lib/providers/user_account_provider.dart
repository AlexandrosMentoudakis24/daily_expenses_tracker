import 'package:daily_expense_tracker/models/transaction.dart';
import 'package:daily_expense_tracker/models/user_account.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';

class LoggedUserAccountNotifier extends ChangeNotifier {
  LoggedUserAccountNotifier()
      : loggedAccount = UserAccount(
          accountId: "",
          firstName: "",
          lastName: "",
          balance: 100.0,
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
      balance: 0.0,
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
}

final loggedUserAccountProvider =
    ChangeNotifierProvider<LoggedUserAccountNotifier>((ref) {
  return LoggedUserAccountNotifier();
});
