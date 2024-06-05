import 'package:daily_expense_tracker/providers/transactions_provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:daily_expense_tracker/widgets/modals/modal_contents.dart/answer_modal_content.dart';
import 'package:daily_expense_tracker/models/transactio_category_icons.dart';
import 'package:daily_expense_tracker/models/transaction.dart';

class SingleTransactionContainer extends ConsumerWidget {
  const SingleTransactionContainer({
    required this.transaction,
    super.key,
  });

  final Transaction transaction;

  Future<Answer?> _initDeleteTransactionProcedure(
    BuildContext context,
  ) async {
    final choise = await showModalBottomSheet<Answer?>(
      context: context,
      builder: (context) => const AnswerModalContent(
        title: "Delete Transaction",
      ),
    );

    return choise;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpense = transaction.transactionType == TransactionType.expense;

    final plusOrMinusText = isExpense ? "-" : "+";

    final transactionIcon =
        transactionCategoryIcons[transaction.transactionCategory];

    return Dismissible(
      key: ValueKey(
        transaction.transactionId,
      ),
      confirmDismiss: (direction) async {
        final choise = await _initDeleteTransactionProcedure(context);

        if (choise == null || choise == Answer.cancel) return false;

        ref
            .read(
              transactionsProvider.notifier,
            )
            .deleteSingleTransaction(
              transaction.transactionId,
            );

        return true;
      },
      direction: DismissDirection.endToStart,
      background: Padding(
        padding: const EdgeInsets.only(right: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                color: Colors.black,
              ),
              child: const Row(
                children: [
                  Text(
                    "Deletting",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(180),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              transactionIcon,
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
      ),
    );
  }
}
