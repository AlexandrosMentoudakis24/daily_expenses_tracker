import 'package:flutter/material.dart';

import 'package:daily_expense_tracker/widgets/global_widgets/single_transaction_container.dart';
import 'package:daily_expense_tracker/models/transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    required this.transactionsList,
    super.key,
  });

  final List<Transaction> transactionsList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: transactionsList.length,
      itemBuilder: (context, index) {
        final currentTransaction = transactionsList[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: SingleTransactionContainer(
            transaction: currentTransaction,
          ),
        );
      },
    );
  }
}
