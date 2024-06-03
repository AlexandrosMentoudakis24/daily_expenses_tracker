import 'package:daily_expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';

class SingleTransactionContainer extends StatelessWidget {
  const SingleTransactionContainer({
    required this.transaction,
    super.key,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final isExpense = transaction.transactionType == TransactionType.expense;

    final plusOrMinusText = isExpense ? "-" : "+";

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(180),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            transaction.transactionIcon,
            size: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              transaction.transactionInfo,
              textScaler: const TextScaler.linear(1.1),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 19,
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Text(
              "$plusOrMinusText ${transaction.amount} \$",
              textScaler: const TextScaler.linear(1.1),
              style: TextStyle(
                color: isExpense ? Colors.red : Colors.green,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
