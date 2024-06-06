import 'package:daily_expense_tracker/widgets/modals/modal_contents.dart/new_category_icon_modal_content.dart';
import 'package:daily_expense_tracker/models/transactio_category_icons.dart';
import 'package:daily_expense_tracker/utils/converters/convert_enum_values.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:daily_expense_tracker/providers/new_transaction_provider.dart';

class NewTransactionCategorySelection extends ConsumerStatefulWidget {
  const NewTransactionCategorySelection({super.key});

  @override
  ConsumerState<NewTransactionCategorySelection> createState() =>
      _NewTransactionCategorySelectionState();
}

class _NewTransactionCategorySelectionState
    extends ConsumerState<NewTransactionCategorySelection> {
  var transactionCategory = TransactionCategory.superMarket;

  void _selectNewTransactionCategoryIcon() async {
    final choise = await showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      context: context,
      builder: (context) => const NewCategoryIconModalContent(),
    );

    if (choise == null) return;

    final newTransactionCategory = choise;

    setState(() {
      transactionCategory = newTransactionCategory;
    });

    ref
        .read(newTransactionProvider.notifier)
        .setNewTransactionCategory(newTransactionCategory);
  }

  @override
  Widget build(BuildContext context) {
    final newTransactionProv = ref.watch(newTransactionProvider);

    final transactionCategory =
        newTransactionProv.newTransaction.transactionCategory;

    final newTransactionIcon = transactionCategoryIcons[transactionCategory];

    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth * 0.68,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: screenWidth * 0.68 * 0.8,
                  child: Text(
                    convertEnumToString(transactionCategory),
                    textScaler: const TextScaler.linear(1.1),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                Icon(
                  newTransactionIcon,
                  color: Colors.white,
                  size: 25,
                ),
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: _selectNewTransactionCategoryIcon,
            child: Container(
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 3,
                ),
              ),
              child: const Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
