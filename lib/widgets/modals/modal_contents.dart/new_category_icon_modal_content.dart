import 'package:flutter/material.dart';

import 'package:daily_expense_tracker/widgets/global_widgets/single_category_icon_item.dart';
import 'package:daily_expense_tracker/utils/converters/convert_enum_values.dart';
import 'package:daily_expense_tracker/models/transaction_category_icons.dart';

const Color _textColor = Colors.white;
const Color _bgColor = Colors.black;

class NewCategoryIconModalContent extends StatefulWidget {
  const NewCategoryIconModalContent({super.key});

  @override
  State<NewCategoryIconModalContent> createState() =>
      _NewCategoryIconModalContentState();
}

class _NewCategoryIconModalContentState
    extends State<NewCategoryIconModalContent> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final verticalMargin = screenHeight * 0.15;
    const contentPadding = 15.0;
    const topRowHeight = 40.0;

    final availableContentHeight =
        screenHeight - (2 * verticalMargin) - contentPadding - topRowHeight;

    return Container(
      width: screenWidth * 0.9,
      margin: EdgeInsets.symmetric(
        vertical: verticalMargin,
      ),
      padding: const EdgeInsets.fromLTRB(
        contentPadding,
        contentPadding,
        contentPadding,
        0.0,
      ),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              height: topRowHeight,
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(
                  Icons.close,
                  color: _textColor,
                  size: 36,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: const Text(
              "Select Category",
              textScaler: TextScaler.linear(1.2),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: _textColor,
                fontSize: 22,
              ),
            ),
          ),
          Container(
            height: availableContentHeight - 60,
            padding: const EdgeInsets.only(top: 20),
            child: ListView.builder(
              itemCount: TransactionCategory.values.length,
              itemBuilder: (context, index) {
                final currentCategory = TransactionCategory.values[index];
                final currentCategoryIcon =
                    transactionCategoryIcons[currentCategory];

                final formattedString = convertEnumToString(currentCategory);

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(currentCategory);
                  },
                  child: SingleCategoryIconItem(
                    itemHeight: 70,
                    itemWidth: screenWidth * 0.9,
                    title: formattedString,
                    icon: currentCategoryIcon!,
                    textColor: _textColor,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
