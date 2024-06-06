import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:daily_expense_tracker/providers/transactions_provider.dart';
import 'package:daily_expense_tracker/models/transaction.dart';

class TransactionFiltersNotifier extends StateNotifier<TransactionType> {
  TransactionFiltersNotifier()
      : super(
          TransactionType.income,
        );

  void setNewTransactionType(TransactionType newTransactionType) {
    state = newTransactionType;
  }
}

final transactionFiltersProvider =
    StateNotifierProvider<TransactionFiltersNotifier, TransactionType>(
  (ref) {
    return TransactionFiltersNotifier();
  },
);

final filteredTransactionsProvider = Provider((ref) {
  final transactionsProv = ref.watch(transactionsProvider);
  final transactionFilters = ref.watch(transactionFiltersProvider);

  final existingTransactions = transactionsProv.existingTransactions;

  return existingTransactions.where((t) {
    if (t.transactionType == transactionFilters) return true;

    return false;
  }).toList();
});
