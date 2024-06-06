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
