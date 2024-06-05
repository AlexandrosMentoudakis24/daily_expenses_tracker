import 'package:intl/intl.dart';

import 'package:daily_expense_tracker/models/transactio_category_icons.dart';

enum TransactionType {
  income,
  expense,
}

class Transaction {
  Transaction({
    required this.transactionId,
    required this.transactionInfo,
    required this.transactionCategory,
    required this.transactionType,
    required this.amount,
    this.createdAt,
  });

  final String transactionId;
  String transactionInfo;
  TransactionCategory transactionCategory;
  TransactionType transactionType;
  double amount;
  DateTime? createdAt;

  static List<Transaction> formatAll(
    List<Map<String, dynamic>> mappedTransactionInfosList,
  ) {
    List<Transaction> formattedTransactionsList = [];

    if (mappedTransactionInfosList.isNotEmpty) {
      for (var i = 0; i < mappedTransactionInfosList.length; i++) {
        final formattedTransaction = Transaction.formatFromMap(
          mappedTransactionInfosList[i],
        );

        formattedTransactionsList.add(formattedTransaction);
      }
    }

    return formattedTransactionsList;
  }

  static Transaction formatFromMap(
    Map<String, dynamic> mappedTransactionInfos,
  ) {
    final TransactionCategory transactionCategory =
        TransactionCategory.values.firstWhere(
      (t) => t.name == mappedTransactionInfos["transactionCategory"],
    );

    final TransactionType transactionType = TransactionType.values.firstWhere(
      (t) => t.name == mappedTransactionInfos["transactionType"],
    );

    return Transaction(
      transactionId: mappedTransactionInfos["_id"],
      transactionInfo: mappedTransactionInfos["transactionInfo"],
      transactionCategory: transactionCategory,
      transactionType: transactionType,
      amount: double.parse(
        mappedTransactionInfos["amount"].toString(),
      ),
      createdAt: DateFormat(
        "dd-MM-yyyy hh:mm:ss",
      ).parse(
        mappedTransactionInfos["createdAt"],
      ),
    );
  }
}
