import 'package:flutter/material.dart';

import 'package:basic_utils/basic_utils.dart';
import 'package:collection/collection.dart';

import 'package:daily_expense_tracker/utils/converters/convert_enum_values.dart';
import 'package:daily_expense_tracker/colors/custom_colors.dart';

Widget chooseModalContent(
  BuildContext context,
  List<Enum> availableOptions,
  Map<Enum, IconData> availableOptionIcons,
  String infoTitle,
) =>
    Container(
      decoration: const BoxDecoration(
        color: CustomColors.primaryBgColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      height: 200,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            infoTitle,
            textScaler: const TextScaler.linear(1.1),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: availableOptions
                .mapIndexed(
                  (index, enumOption) => Column(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(enumOption),
                        icon: Icon(
                          availableOptionIcons[enumOption],
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        StringUtils.capitalize(
                          convertEnumToString(
                            enumOption,
                          ),
                        ),
                        textScaler: const TextScaler.linear(1.1),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
