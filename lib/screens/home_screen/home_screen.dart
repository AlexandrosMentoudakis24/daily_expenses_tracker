import 'package:daily_expense_tracker/colors/custom_colors.dart';
import 'package:daily_expense_tracker/providers/transactions_provider.dart';
import 'package:daily_expense_tracker/widgets/global_widgets/empty_screen_content.dart';
import 'package:flutter/material.dart';

import 'package:daily_expense_tracker/modals/modal_contents.dart/new_transaction_modal_content.dart';
import 'package:daily_expense_tracker/widgets/global_widgets/transaction_list.dart';
import 'package:daily_expense_tracker/widgets/home_screen/balance_container.dart';
import 'package:daily_expense_tracker/models/transaction.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late List<Transaction> transactionsList;

  void _onAddNewTransactionPressed() async {
    await showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: (context) => const NewTransactionModalContent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final transactionsProv = ref.watch(transactionsProvider);

    transactionsList = [...transactionsProv.existingTransactions];

    final isEmptyList = transactionsList.isEmpty;

    return Scaffold(
        floatingActionButton: GestureDetector(
          onTap: _onAddNewTransactionPressed,
          child: Container(
            alignment: Alignment.center,
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 70, 167, 246),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.add,
              size: 35,
              color: Colors.white,
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text(
            "Daily Expense Tracker",
          ),
          actions: const <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.search,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const BalanceContainer(),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Transactions",
                      textScaler: TextScaler.linear(1.1),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "See all",
                        textScaler: TextScaler.linear(1.1),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
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
        ));
  }
}
