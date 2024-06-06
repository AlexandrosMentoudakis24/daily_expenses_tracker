import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:daily_expense_tracker/providers/transactions_provider.dart';
import 'package:daily_expense_tracker/utils/date_utils/date_utils.dart';
import 'package:daily_expense_tracker/colors/custom_colors.dart';

class BarsChart extends ConsumerStatefulWidget {
  const BarsChart({super.key});

  @override
  ConsumerState<BarsChart> createState() => _BarsChartState();
}

class _BarsChartState extends ConsumerState<BarsChart> {
  List<Map<String, dynamic>> transactionValues = [];

  double maxValue = 0.0;

  void _constructDailyTransactionsChart() {
    final existingTransactions =
        ref.read(transactionsProvider).existingTransactions;

    transactionValues = CustomDateUtils.findSpecifiedValuesForNDays(
      existingTransactions,
      7,
    );

    for (final tObj in transactionValues) {
      maxValue = max(
        maxValue,
        max(
          tObj["expenses"],
          tObj["incomes"],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _constructDailyTransactionsChart();
  }

  @override
  Widget build(BuildContext context) {
    final existingTransactions =
        ref.watch(transactionsProvider).existingTransactions;

    return BarChart(
      BarChartData(
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              reservedSize: 45,
              showTitles: true,
              interval: maxValue / 5.0,
              getTitlesWidget: (value, meta) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        value.toString().split(".")[0],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              reservedSize: 25,
              showTitles: true,
              getTitlesWidget: (value, meta) {
                var extraString = "th";
                if (value == 1) extraString = "st";
                if (value == 2) extraString = "nd";
                if (value == 3) extraString = "rd";

                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "${value.toString().split(".")[0]}$extraString",
                  ),
                );
              },
            ),
          ),
          rightTitles: AxisTitles(),
          topTitles: AxisTitles(),
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
        maxY: maxValue.ceilToDouble(),
        groupsSpace: 30,
        minY: 0,
        barGroups: [
          for (final tObj in transactionValues)
            BarChartGroupData(
              x: tObj["date"],
              barRods: [
                BarChartRodData(
                  toY: tObj["expenses"],
                  color: CustomColors.expenseBarFillColor,
                ),
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
