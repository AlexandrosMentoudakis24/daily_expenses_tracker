import 'package:flutter/material.dart';

import 'package:daily_expense_tracker/utils/enum_values/enum_values.dart';
import 'package:daily_expense_tracker/colors/custom_colors.dart';

class DateFilterButtonsContainer extends StatefulWidget {
  const DateFilterButtonsContainer({
    required this.onDateTypeChangedHandler,
    super.key,
  });

  final void Function(DateSection dateSection) onDateTypeChangedHandler;

  @override
  State<DateFilterButtonsContainer> createState() =>
      _DateFilterButtonsContainerState();
}

class _DateFilterButtonsContainerState
    extends State<DateFilterButtonsContainer> {
  var activeDateSection = DateSection.values[0];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
        color: Colors.white,
      ),
      child: Row(
        children: [
          ...DateSection.values.map(
            (enumValue) {
              final isActive = activeDateSection == enumValue;

              return Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final availHeight = constraints.constrainHeight();
                    final availWidth = constraints.constrainWidth();

                    return GestureDetector(
                      onTap: () {
                        if (activeDateSection == enumValue) return;

                        widget.onDateTypeChangedHandler(enumValue);

                        setState(() {
                          activeDateSection = enumValue;
                        });
                      },
                      child: Container(
                        height: availHeight,
                        width: availWidth,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isActive
                              ? CustomColors.primaryBgColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(90),
                        ),
                        child: Text(
                          enumValue.name.toUpperCase(),
                          textScaler: const TextScaler.linear(1.1),
                          style: TextStyle(
                            letterSpacing: 2,
                            color: isActive
                                ? Colors.white
                                : CustomColors.primaryBgColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
