import 'package:daily_expense_tracker/utils/enum_values/enum_values.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:daily_expense_tracker/widgets/global_widgets/charts/chart_container.dart';
import 'package:daily_expense_tracker/widgets/global_widgets/empty_screen_content.dart';
import 'package:daily_expense_tracker/widgets/global_widgets/transaction_list.dart';
import 'package:daily_expense_tracker/widgets/home_screen/balance_container.dart';
import 'package:daily_expense_tracker/providers/transactions_provider.dart';
import 'package:daily_expense_tracker/models/transaction.dart';

Widget _chartContainer({
  required double maxWidth,
}) {
  return Container(
    height: 250,
    width: maxWidth,
    margin: const EdgeInsets.only(top: 25.0),
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 15,
    ),
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(24),
    ),
    child: const ChartContainer(
      chartType: ChartType.lines,
    ),
  );
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late List<Transaction> transactionsList;

  Future<void> _fetchTransactions() async {
    await ref.read(transactionsProvider.notifier).fetchAllTransactions();

    if (!mounted) return;
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(milliseconds: 1),
      _fetchTransactions,
    );
  }

  @override
  Widget build(BuildContext context) {
    final transactionsProv = ref.watch(transactionsProvider);

    transactionsList = [...transactionsProv.existingTransactions];

    final isEmptyList = transactionsList.isEmpty;

    return RefreshIndicator(
      onRefresh: _fetchTransactions,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const BalanceContainer(),
              if (false)
                _chartContainer(
                  maxWidth: MediaQuery.of(context).size.width,
                ),
              const SizedBox(
                height: 25,
              ),
              const Row(
                children: [
                  Text(
                    "Transactions",
                    textScaler: TextScaler.linear(1.1),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              isEmptyList
                  ? const EmptyScreenContent()
                  : TransactionList(
                      transactionsList: [
                        ...transactionsList,
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
