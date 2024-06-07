import 'package:basic_utils/basic_utils.dart';

String convertEnumToString(Enum enumValue) {
  final splittedWord = StringUtils.camelCaseToLowerUnderscore(enumValue.name);

  final formattedWord = splittedWord.split("_");

  var finalFormattedWord = "";

  for (var splitString in formattedWord) {
    var capitalizedWord = "";

    capitalizedWord = StringUtils.capitalize(splitString);

    finalFormattedWord += "$capitalizedWord ";
  }

  return finalFormattedWord;
}

String convertIntToMonth(int month) {
  if (month < 1 || month > 12) {
    throw ArgumentError('Month must be between 1 and 12');
  }

  List<String> monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  return monthNames[month - 1];
}
