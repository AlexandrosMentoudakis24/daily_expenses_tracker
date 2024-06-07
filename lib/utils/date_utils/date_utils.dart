import 'package:intl/intl.dart';

import 'package:daily_expense_tracker/models/transaction.dart';

class CustomDateUtils {
  static bool isAtLeastNDaysDifference(DateTime dateTime, int dateDifference) {
    DateTime now = DateTime.now();

    Duration difference = now.difference(dateTime).abs();

    return difference.inDays <= dateDifference;
  }

  static Map<String, double> createLastNDays(int dateDifference) {
    Map<String, double> lastNDays = {};

    DateFormat formatter = DateFormat("yyyy-MM-dd");

    for (int i = 0; i < dateDifference; i++) {
      DateTime date = DateTime.now().subtract(
        Duration(days: i),
      );

      String formattedDate = formatter.format(date);

      lastNDays[formattedDate] = 0.0;
    }

    return lastNDays;
  }

  static List<Map<String, dynamic>> findSpecifiedValuesForNDays(
    List<Transaction> existingTransactions,
    int dateDifference,
  ) {
    List<Map<String, dynamic>> transactionValues = [];

    var expenses = createLastNDays(dateDifference);
    var incomes = createLastNDays(dateDifference);

    for (final t in existingTransactions) {
      if (!isAtLeastNDaysDifference(
        t.createdAt!,
        dateDifference - 1,
      )) continue;

      DateFormat formatter = DateFormat("yyyy-MM-dd");
      String formattedDate = formatter.format(t.createdAt!);

      if (t.transactionType == TransactionType.expense) {
        expenses[formattedDate] = expenses[formattedDate]! + t.amount;

        continue;
      }

      incomes[formattedDate] = incomes[formattedDate]! + t.amount;
    }

    for (final el in expenses.entries) {
      final currentKey = el.key;

      final dateNum = currentKey.toString().split("-")[2];

      final formattedDateNum = dateNum.split("");

      dynamic constructedDate = "";

      if (formattedDateNum[0] == "0") {
        constructedDate = formattedDateNum[1];
      } else {
        constructedDate = "${formattedDateNum[0]}${formattedDateNum[1]}";
      }

      constructedDate = int.parse(constructedDate);

      transactionValues.insert(
        0,
        {
          "date": constructedDate,
          "expenses": el.value,
          "incomes": incomes[currentKey],
        },
      );
    }

    return transactionValues;
  }

  static bool isAtLeastNMonthsDifference(
    DateTime dateTime,
    int dateDifference,
  ) {
    DateTime now = DateTime.now();
    int yearDifference = now.year - dateTime.year;
    int monthDifference = now.month - dateTime.month;

    int totalMonthDifference = (yearDifference * 12) + monthDifference;

    return totalMonthDifference.abs() <= 6;
  }

  static Map<String, double> createLastNMonths(int dateDifference) {
    Map<String, double> last7Months = {};

    DateFormat formatter = DateFormat('yyyy-MM');

    DateTime now = DateTime.now();

    for (int i = 0; i < 7; i++) {
      DateTime date = DateTime(now.year, now.month - i, 1);

      String formattedDate = formatter.format(date);

      last7Months[formattedDate] = 0.0;
    }

    return last7Months;
  }

  static List<Map<String, dynamic>> findSpecifiedValuesForNMonths(
    List<Transaction> existingTransactions,
    int dateDifference,
  ) {
    List<Map<String, dynamic>> transactionValues = [];

    var expenses = createLastNMonths(dateDifference);
    var incomes = createLastNMonths(dateDifference);

    for (final t in existingTransactions) {
      if (!isAtLeastNMonthsDifference(
        t.createdAt!,
        dateDifference - 1,
      )) continue;

      DateFormat formatter = DateFormat("yyyy-MM");
      String formattedDate = formatter.format(t.createdAt!);

      if (t.transactionType == TransactionType.expense) {
        expenses[formattedDate] = expenses[formattedDate]! + t.amount;

        continue;
      }

      incomes[formattedDate] = incomes[formattedDate]! + t.amount;
    }

    for (final el in expenses.entries) {
      final currentKey = el.key;

      final dateNum = currentKey.toString().split("-")[1];

      final formattedDateNum = dateNum.split("");

      dynamic constructedDate = "";

      if (formattedDateNum[0] == "0") {
        constructedDate = formattedDateNum[1];
      } else {
        constructedDate = "${formattedDateNum[0]}${formattedDateNum[1]}";
      }

      constructedDate = int.parse(constructedDate);

      transactionValues.insert(
        0,
        {
          "date": constructedDate,
          "expenses": el.value,
          "incomes": incomes[currentKey],
        },
      );
    }

    return transactionValues;
  }
}
