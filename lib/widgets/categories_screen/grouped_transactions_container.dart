import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:daily_expense_tracker/widgets/global_widgets/empty_screen_content.dart';
import 'package:daily_expense_tracker/widgets/global_widgets/transaction_list.dart';
import 'package:daily_expense_tracker/providers/transaction_filters_provider.dart';

class GroupedTransactionsContainer extends ConsumerStatefulWidget {
  const GroupedTransactionsContainer({super.key});

  @override
  ConsumerState<GroupedTransactionsContainer> createState() =>
      _GroupedTransactionsContainerState();
}

class _GroupedTransactionsContainerState
    extends ConsumerState<GroupedTransactionsContainer> {
  @override
  Widget build(BuildContext context) {
    final filteredTransactions = ref.watch(filteredTransactionsProvider);

    final isEmptyList = filteredTransactions.isEmpty;

    return isEmptyList
        ? const EmptyScreenContent()
        : TransactionList(
            transactionsList: [
              ...filteredTransactions,
            ],
          );
  }
}
