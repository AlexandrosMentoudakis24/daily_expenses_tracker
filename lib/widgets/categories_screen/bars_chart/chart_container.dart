import 'package:flutter/material.dart';

import 'package:daily_expense_tracker/widgets/categories_screen/bars_chart/date_filter_buttons_container.dart';
import 'package:daily_expense_tracker/widgets/categories_screen/bars_chart/bars_chart.dart';
import 'package:daily_expense_tracker/utils/enum_values/enum_values.dart';

class ChartContainer extends StatefulWidget {
  const ChartContainer({super.key});

  @override
  State<ChartContainer> createState() => _ChartContainerState();
}

class _ChartContainerState extends State<ChartContainer> {
  var _activeDateSection = DateSection.values[0];

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
                    child: DateFilterButtonsContainer(
                      onDateTypeChangedHandler: (newDateSection) {
                        setState(() {
                          _activeDateSection = newDateSection;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 150,
              width: constraints.maxWidth,
              margin: const EdgeInsets.only(top: 70),
              child: BarsChart(
                dateSection: _activeDateSection,
              ),
            ),
          ],
        );
      },
    );
  }
}
