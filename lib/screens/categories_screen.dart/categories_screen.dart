import 'package:flutter/material.dart';

import 'package:daily_expense_tracker/widgets/categories_screen/grouped_transactions_container.dart';
import 'package:daily_expense_tracker/widgets/categories_screen/transaction_filters_container.dart';
import 'package:daily_expense_tracker/widgets/global_widgets/charts/chart_container.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const ChartContainer(),
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
    );
  }
}
