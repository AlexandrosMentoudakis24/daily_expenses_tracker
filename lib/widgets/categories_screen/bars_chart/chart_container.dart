import 'package:flutter/material.dart';

import 'package:daily_expense_tracker/widgets/categories_screen/bars_chart/date_filter_buttons_container.dart';
import 'package:daily_expense_tracker/widgets/categories_screen/bars_chart/bars_chart.dart';

class ChartContainer extends StatelessWidget {
  const ChartContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;

        return Stack(
          children: [
            SizedBox(
              width: constraints.maxWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: maxWidth * 0.7,
                    child: const DateFilterButtonsContainer(),
                  ),
                ],
              ),
            ),
            Container(
              height: 150,
              width: constraints.maxWidth,
              margin: const EdgeInsets.only(top: 70),
              child: const BarsChart(),
            ),
          ],
        );
      },
    );
  }
}
