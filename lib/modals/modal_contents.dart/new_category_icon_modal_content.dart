import 'package:daily_expense_tracker/models/transactio_category_icons.dart';
import 'package:daily_expense_tracker/utils/converter/convert_enum_values.dart';
import 'package:daily_expense_tracker/widgets/global_widgets/single_category_icon_item.dart';
import 'package:flutter/material.dart';

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

    final verticalMargin = screenHeight * 0.1;
    const contentPadding = 15.0;
    const topRowHeight = 40.0;

    final availableContentHeight =
        screenHeight - (2 * verticalMargin) - contentPadding - topRowHeight;

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: verticalMargin,
      ),
      padding: const EdgeInsets.fromLTRB(
        contentPadding,
        contentPadding,
        contentPadding,
        0.0,
      ),
      width: screenWidth * 0.9,
      decoration: BoxDecoration(
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
            child: SizedBox(
              height: topRowHeight,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 25),
                    width: screenWidth * 0.9 - (2 * contentPadding) - 50,
                    child: const Text(
                      "Select Preffered Icon",
                      textScaler: TextScaler.linear(1.1),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 30),
            height: availableContentHeight - 30,
            child: ListView.builder(
              itemCount: TransactionCategories.values.length,
              itemBuilder: (context, index) {
                final currentCategory = TransactionCategories.values[index];
                final currentCategoryIcon =
                    transactionCategoryIcons[currentCategory];

                final formattedString = convertEnumToString(currentCategory);

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop({
                      "title": formattedString,
                      "icon": currentCategoryIcon,
                    });
                  },
                  child: SingleCategoryIconItem(
                    itemHeight: 70,
                    itemWidth: screenWidth * 0.9,
                    title: formattedString,
                    icon: currentCategoryIcon!,
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
