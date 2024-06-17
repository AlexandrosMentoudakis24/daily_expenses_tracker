import 'package:daily_expense_tracker/utils/enum_values/enum_values.dart';
import 'package:flutter/material.dart';

Widget emptyBarChartContent(DateSection currentDateSection) {
  final String dateSectionString =
      currentDateSection == DateSection.daily ? "days" : "months";

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 35.0),
    child: Center(
      child: Text(
        "We could not find any recorded transaction for the last 7 $dateSectionString!",
        textAlign: TextAlign.center,
        textScaler: const TextScaler.linear(1.1),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    ),
  );
}
