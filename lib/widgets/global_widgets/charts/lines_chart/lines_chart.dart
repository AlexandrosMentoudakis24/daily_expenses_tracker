import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:daily_expense_tracker/widgets/global_widgets/charts/empty_bar_content.dart';
import 'package:daily_expense_tracker/utils/converters/convert_data_to_flspot.dart';
import 'package:daily_expense_tracker/utils/converters/convert_enum_values.dart';
import 'package:daily_expense_tracker/providers/transactions_provider.dart';
import 'package:daily_expense_tracker/utils/enum_values/enum_values.dart';
import 'package:daily_expense_tracker/utils/date_utils/date_utils.dart';

class LinesChart extends ConsumerStatefulWidget {
  const LinesChart({
    required this.dateSection,
    required this.showIncomes,
    required this.showExpenses,
    super.key,
  });

  final DateSection dateSection;
  final bool showIncomes;
  final bool showExpenses;

  @override
  ConsumerState<LinesChart> createState() => _LinesChartState();
}

class _LinesChartState extends ConsumerState<LinesChart> {
  List<Map<String, dynamic>> transactionValues = [];
  List<LineChartBarData> lineChartBarData = [];

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

    lineChartBarData = convertDataToLineChartBarData(
      dataObjList: transactionValues,
      isMontlyDateSection: widget.dateSection == DateSection.monthly,
      showIncomes: widget.showIncomes,
      showExpenses: widget.showExpenses,
    );
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

    final currentDateSection = widget.dateSection;
    final isMontlyDateSection = currentDateSection == DateSection.monthly;

    final isEmptyBarChart = maxValue == 0.0;

    return isEmptyBarChart
        ? emptyBarChartContent(currentDateSection)
        : Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: LineChart(
              curve: Curves.easeInOut,
              LineChartData(
                maxY: maxValue!.ceilToDouble() +
                    (maxValue! * 1 / 5).ceilToDouble(),
                minY: 0,
                minX: isMontlyDateSection
                    ? 0
                    : double.parse("${transactionValues[0]['date']}"),
                maxX: isMontlyDateSection
                    ? 6
                    : double.parse(
                        "${transactionValues[transactionValues.length - 1]['date']}"),
                gridData: const FlGridData(
                  show: false,
                ),
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
                      reservedSize: 25,
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        int? index;
                        double? newValue;

                        if (isMontlyDateSection) {
                          index = int.parse(
                            value.toString().split(".")[0],
                          );

                          newValue = double.parse(
                            "${transactionValues[index]['date']}",
                          );
                        }

                        final extraString = formatString(
                          isMontlyDateSection ? newValue! : value,
                        );

                        return Padding(
                          padding: const EdgeInsets.only(top: 7.0, right: 10),
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
                lineBarsData: lineChartBarData,
              ),
            ),
          );
  }
}
