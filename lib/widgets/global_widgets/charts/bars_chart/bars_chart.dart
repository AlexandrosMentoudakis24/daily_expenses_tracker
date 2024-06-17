import 'dart:math';

import 'package:daily_expense_tracker/widgets/global_widgets/charts/empty_bar_content.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:daily_expense_tracker/utils/converters/convert_enum_values.dart';
import 'package:daily_expense_tracker/providers/transactions_provider.dart';
import 'package:daily_expense_tracker/utils/enum_values/enum_values.dart';
import 'package:daily_expense_tracker/utils/date_utils/date_utils.dart';
import 'package:daily_expense_tracker/colors/custom_colors.dart';

class BarsChart extends ConsumerStatefulWidget {
  const BarsChart({
    required this.dateSection,
    required this.showIncomes,
    required this.showExpenses,
    super.key,
  });

  final DateSection dateSection;
  final bool showIncomes;
  final bool showExpenses;

  @override
  ConsumerState<BarsChart> createState() => _BarsChartState();
}

class _BarsChartState extends ConsumerState<BarsChart> {
  List<Map<String, dynamic>> transactionValues = [];

  double? maxValue;

  void _constructTransactionsChart() {
    final existingTransactions =
        ref.read(transactionsProvider).existingTransactions;

    if (widget.dateSection == DateSection.daily) {
      transactionValues = CustomDateUtils.findSpecifiedValuesForNDays(
        existingTransactions,
        7,
      );
    } else {
      transactionValues = CustomDateUtils.findSpecifiedValuesForNMonths(
        existingTransactions,
        7,
      );
    }

    maxValue = 0.0;

    for (final tObj in transactionValues) {
      maxValue = max(
        maxValue!,
        max(
          tObj["expenses"],
          tObj["incomes"],
        ),
      );
    }
  }

  String formatString(double providedValue) {
    var initialString = providedValue.toString();

    if (widget.dateSection == DateSection.daily) {
      initialString = initialString.split(".")[0];

      var extraString = "th";

      if (providedValue == 1) extraString = "st";
      if (providedValue == 2) extraString = "nd";
      if (providedValue == 3) extraString = "rd";

      initialString += extraString;

      return initialString;
    }

    initialString = convertIntToMonth(
      int.parse(
        providedValue.toString().split(".")[0],
      ),
    );

    return initialString;
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(transactionsProvider).existingTransactions;

    _constructTransactionsChart();

    final isEmptyBarChart = maxValue == 0.0;

    return isEmptyBarChart
        ? emptyBarChartContent(widget.dateSection)
        : BarChart(
            BarChartData(
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    reservedSize: 50,
                    showTitles: true,
                    interval: maxValue! / 5.0,
                    getTitlesWidget: (value, meta) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              value.toString().split(".")[0],
                              textScaler: const TextScaler.linear(1.1),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    reservedSize: 30,
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final extraString = formatString(value);

                      return Padding(
                        padding: const EdgeInsets.only(top: 7.0),
                        child: Text(
                          extraString,
                          textScaler: const TextScaler.linear(1.1),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                rightTitles: const AxisTitles(),
                topTitles: const AxisTitles(),
              ),
              borderData: FlBorderData(
                show: true,
                border: const Border(
                  left: BorderSide(
                    color: Colors.white,
                    width: 2,
                  ),
                  bottom: BorderSide(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
              gridData: const FlGridData(
                show: false,
              ),
              maxY:
                  maxValue!.ceilToDouble() + (maxValue! * 1 / 5).ceilToDouble(),
              groupsSpace: 30,
              minY: 0,
              barGroups: [
                for (final tObj in transactionValues)
                  BarChartGroupData(
                    x: tObj["date"],
                    barRods: [
                      if (widget.showExpenses)
                        BarChartRodData(
                          toY: tObj["expenses"],
                          color: CustomColors.expenseBarFillColor,
                        ),
                      if (widget.showIncomes)
                        BarChartRodData(
                          toY: tObj["incomes"],
                          color: CustomColors.incomeBarFillColor,
                        ),
                    ],
                  ),
              ],
            ),
            swapAnimationCurve: Curves.linear,
          );
  }
}
