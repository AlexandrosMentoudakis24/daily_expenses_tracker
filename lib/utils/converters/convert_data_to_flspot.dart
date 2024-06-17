import 'package:fl_chart/fl_chart.dart';

import 'package:daily_expense_tracker/colors/custom_colors.dart';

List<LineChartBarData> convertDataToLineChartBarData({
  required List<Map<String, dynamic>> dataObjList,
  required bool isMontlyDateSection,
  required bool showIncomes,
  required bool showExpenses,
}) {
  final List<FlSpot> incomesFlSpotsList = [];
  final List<FlSpot> expensesFlSpotsList = [];

  if (isMontlyDateSection) {
    incomesFlSpotsList.add(
      const FlSpot(
        0.0,
        0.0,
      ),
    );
    expensesFlSpotsList.add(
      const FlSpot(
        0.0,
        0.0,
      ),
    );
  }

  for (final tObj in dataObjList) {
    final FlSpot newIncomeFlSpot = FlSpot(
      double.parse(
        tObj["date"].toString(),
      ),
      tObj["incomes"],
    );

    final FlSpot newExpenseFlSpot = FlSpot(
      double.parse(
        tObj["date"].toString(),
      ),
      tObj["expenses"],
    );

    incomesFlSpotsList.add(newIncomeFlSpot);
    expensesFlSpotsList.add(newExpenseFlSpot);
  }

  return [
    LineChartBarData(
      show: showIncomes,
      isCurved: true,
      preventCurveOvershootingThreshold: 1,
      preventCurveOverShooting: true,
      spots: incomesFlSpotsList,
      color: CustomColors.incomeBarFillColor,
    ),
    LineChartBarData(
      show: showExpenses,
      isCurved: true,
      preventCurveOvershootingThreshold: 1,
      preventCurveOverShooting: true,
      spots: expensesFlSpotsList,
      color: CustomColors.expenseBarFillColor,
    ),
  ];
}
