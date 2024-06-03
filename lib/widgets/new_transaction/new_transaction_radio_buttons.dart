import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:basic_utils/basic_utils.dart';

import 'package:daily_expense_tracker/providers/new_transaction_provider.dart';
import 'package:daily_expense_tracker/models/transaction.dart';

class NewTransactionRadioButtons extends ConsumerStatefulWidget {
  const NewTransactionRadioButtons({super.key});

  @override
  ConsumerState<NewTransactionRadioButtons> createState() =>
      _NewTransactionRadioButtonsState();
}

class _NewTransactionRadioButtonsState
    extends ConsumerState<NewTransactionRadioButtons> {
  @override
  Widget build(BuildContext context) {
    final newTransactionProv = ref.watch(newTransactionProvider);

    final newTransactionType =
        newTransactionProv.newTransaction.transactionType;

    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Transaction Type",
            textScaler: TextScaler.linear(1.1),
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
          Row(
            children: <Widget>[
              ...TransactionType.values.map(
                (enumValue) {
                  final isActive = newTransactionType == enumValue;

                  final usedColor = enumValue == TransactionType.income
                      ? Colors.green
                      : Colors.red;

                  return Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        ref
                            .read(newTransactionProvider.notifier)
                            .setNewTransactionType(enumValue);
                      },
                      child: SizedBox(
                        width: screenWidth * 1 / TransactionType.values.length,
                        child: Row(
                          children: <Widget>[
                            Radio(
                              activeColor: usedColor,
                              value: enumValue,
                              groupValue: newTransactionType,
                              onChanged: (newValue) {},
                            ),
                            Text(
                              StringUtils.capitalize(
                                enumValue.name,
                              ),
                              textScaler: const TextScaler.linear(1.1),
                              style: TextStyle(
                                letterSpacing: 1.1,
                                color: isActive ? usedColor : Colors.white,
                                fontSize: 21,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
