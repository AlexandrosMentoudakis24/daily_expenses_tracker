import 'package:daily_expense_tracker/widgets/home_screen/balance_container.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxHeight = constraints.maxHeight;
          final maxWidth = constraints.maxWidth;

          return Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const BalanceContainer(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
