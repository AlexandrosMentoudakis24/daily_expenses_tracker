import 'package:flutter/material.dart';

enum TransactionType {
  income,
  expense,
}

class Transaction {
  Transaction({
    required this.transactionId,
    required this.transactionIcon,
    required this.transactionInfo,
    required this.transactionType,
    required this.amount,
  });

  final String transactionId;
  TransactionType transactionType;
  String transactionInfo;
  IconData transactionIcon;
  double amount;
}
