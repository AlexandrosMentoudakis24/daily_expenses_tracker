import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import 'package:daily_expense_tracker/utils/constants/web_server_uri_constants.dart';
import 'package:daily_expense_tracker/models/transactio_category_icons.dart';
import 'package:daily_expense_tracker/models/transaction.dart';

class NewTransactionNotifier extends ChangeNotifier {
  NewTransactionNotifier()
      : newTransaction = Transaction(
          transactionId: "",
          transactionInfo: "",
          transactionCategory: TransactionCategory.values[0],
          transactionType: TransactionType.income,
          amount: 0.0,
        );

  Transaction newTransaction;

  void clearNewTransaction() {
    newTransaction = Transaction(
      transactionId: "",
      transactionInfo: "",
      transactionCategory: TransactionCategory.values[0],
      transactionType: TransactionType.income,
      amount: 0.0,
    );

    notifyListeners();
  }

  void setNewTransactionInfo(String newTransactionInfo) {
    newTransaction.transactionInfo = newTransactionInfo;

    notifyListeners();
  }

  void setNewTransactionCategory(TransactionCategory newTransactionCategory) {
    newTransaction.transactionCategory = newTransactionCategory;

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

  Future<Transaction?> saveTransactionToDB() async {
    final transactionInfo = newTransaction.transactionInfo;
    final transactionCategory = newTransaction.transactionCategory.name;
    final transactionType = newTransaction.transactionType.name;
    final amount = newTransaction.amount;

    if (transactionInfo.isEmpty || amount <= 0.0) return null;

    final dio = Dio();

    final formData = {
      "transactionInfo": transactionInfo,
      "transactionCategory": transactionCategory,
      "transactionType": transactionType,
      "amount": amount,
    };

    try {
      final response = await dio.post(
        "${WebServer.serverUri}/transactions/saveTransaction",
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
        data: formData,
      );

      if (response.statusCode != 201) {
        return null;
      }

      final responseData = response.data;

      final newTransaction = Transaction.formatFromMap(
        responseData["transaction"],
      );

      return newTransaction;
    } catch (err) {
      throw "Failed to save transaction!";
    }
  }
}

final newTransactionProvider =
    ChangeNotifierProvider<NewTransactionNotifier>((ref) {
  return NewTransactionNotifier();
});
