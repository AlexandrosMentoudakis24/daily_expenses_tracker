import 'package:daily_expense_tracker/colors/custom_colors.dart';
import 'package:daily_expense_tracker/providers/transaction_filters_provider.dart';
import 'package:flutter/material.dart';

import 'package:daily_expense_tracker/models/transaction.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionFiltersContainer extends ConsumerStatefulWidget {
  const TransactionFiltersContainer({super.key});

  @override
  ConsumerState<TransactionFiltersContainer> createState() =>
      _TransactionFiltersContainerState();
}

class _TransactionFiltersContainerState
    extends ConsumerState<TransactionFiltersContainer> {
  @override
  Widget build(BuildContext context) {
    final activeTransactionFilter = ref.watch(transactionFiltersProvider);

    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
        color: Colors.white,
      ),
      child: Row(
        children: [
          ...TransactionType.values.map(
            (enumValue) {
              final isActive = activeTransactionFilter == enumValue;

              return Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final availHeight = constraints.constrainHeight();
                    final availWidth = constraints.constrainWidth();

                    return GestureDetector(
                      onTap: () {
                        if (activeTransactionFilter == enumValue) return;

                        ref
                            .read(transactionFiltersProvider.notifier)
                            .setNewTransactionType(enumValue);
                      },
                      child: Container(
                        height: availHeight,
                        width: availWidth,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isActive
                              ? CustomColors.primaryBgColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(90),
                        ),
                        child: Text(
                          enumValue.name.toUpperCase(),
                          textScaler: const TextScaler.linear(1.2),
                          style: TextStyle(
                            letterSpacing: 1.2,
                            color: isActive
                                ? Colors.white
                                : CustomColors.primaryBgColor,
                            fontSize: 19,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
