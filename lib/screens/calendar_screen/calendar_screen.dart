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
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxHeight = constraints.maxHeight;
        final maxWidth = constraints.maxWidth;

        return const Padding(
          padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BalanceContainer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
