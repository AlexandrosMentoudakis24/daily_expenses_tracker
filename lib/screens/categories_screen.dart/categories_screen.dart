import 'package:flutter/material.dart';

import 'package:daily_expense_tracker/widgets/categories_screen/grouped_transactions_container.dart';
import 'package:daily_expense_tracker/widgets/categories_screen/transaction_filters_container.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
            children: [
              Container(
                height: 180,
                color: Colors.black,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: TransactionFiltersContainer(),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: GroupedTransactionsContainer(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}