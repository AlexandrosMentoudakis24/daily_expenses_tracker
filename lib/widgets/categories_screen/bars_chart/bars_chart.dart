import 'dart:math';

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
    super.key,
  });

  final DateSection dateSection;

  @override
  ConsumerState<BarsChart> createState() => _BarsChartState();
}

class _BarsChartState extends ConsumerState<BarsChart> {
  List<Map<String, dynamic>> transactionValues = [];

  double maxValue = 0.0;

  void _constructTransactionsChart() {
    final existingTransactions =
        ref.read(transactionsProvider).existingTransactions;

    if (widget.dateSection == DateSection.daily) {
      transactionValues = CustomDateUtils.findSpecifiedValuesForNDays(
        existingTransactions,
        7,
      );
    }

    if (widget.dateSection == DateSection.monthly) {
      transactionValues = CustomDateUtils.findSpecifiedValuesForNMonths(
        existingTransactions,
        7,
      );
    }

    if (widget.dateSection == DateSection.yearly) {
      transactionValues = CustomDateUtils.findSpecifiedValuesForNDays(
        existingTransactions,
        7,
      );
    }

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

  String formatString(double providedValue) {
    var initialString = providedValue.toString().split(".")[0];

    switch (widget.dateSection) {
      case DateSection.daily:
        var extraString = "th";

        if (providedValue == 1) extraString = "st";
        if (providedValue == 2) extraString = "nd";
        if (providedValue == 3) extraString = "rd";

        initialString += extraString;

        break;
      case DateSection.monthly:
        initialString = convertIntToMonth(
          int.parse(
            providedValue.toString().split(".")[0],
          ),
        );

        break;
      case DateSection.yearly:
        var extraString = "th";

        if (providedValue == 1) extraString = "st";
        if (providedValue == 2) extraString = "nd";
        if (providedValue == 3) extraString = "rd";

        initialString += extraString;

        break;
      default:
    }

    return initialString;
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(transactionsProvider).existingTransactions;

    _constructTransactionsChart();

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
              reservedSize: 30,
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final extraString = formatString(value);

                return Padding(
                  padding: const EdgeInsets.only(top: 7.0),
                  child: Text(
                    extraString,
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
