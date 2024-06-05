import 'package:flutter/material.dart';

import 'package:daily_expense_tracker/colors/custom_colors.dart';

enum Answer {
  procceed,
  cancel,
}

class AnswerModalContent extends StatelessWidget {
  const AnswerModalContent({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: const BoxDecoration(
        color: CustomColors.primaryBgColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      height: 220,
      width: screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textScaler: const TextScaler.linear(1.3),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          SizedBox(
            width: screenWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...Answer.values.map(
                  (enumValue) {
                    final isAcceptEnum = enumValue == Answer.procceed;

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(enumValue);
                      },
                      child: Container(
                        height: 70,
                        width: 70,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isAcceptEnum ? Colors.green : Colors.red,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          isAcceptEnum ? Icons.delete : Icons.close,
                          color: isAcceptEnum ? Colors.green : Colors.red,
                          size: 30,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
