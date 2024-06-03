import 'package:daily_expense_tracker/modals/modal_contents.dart/new_category_icon_modal_content.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:daily_expense_tracker/providers/new_transaction_provider.dart';

class NewTransactionIconSelection extends ConsumerStatefulWidget {
  const NewTransactionIconSelection({super.key});

  @override
  ConsumerState<NewTransactionIconSelection> createState() =>
      _NewTransactionIconSelectionState();
}

class _NewTransactionIconSelectionState
    extends ConsumerState<NewTransactionIconSelection> {
  var categoryIconName = "Super Market";

  void _selectNewTransactionCategoryIcon() async {
    final choise = await showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      context: context,
      builder: (context) => const NewCategoryIconModalContent(),
    );

    if (choise == null) return;

    final newTitle = choise["title"];
    final newIcon = choise["icon"];

    setState(() {
      categoryIconName = newTitle;
    });

    ref.read(newTransactionProvider.notifier).setNewTransactionIcon(newIcon);
  }

  @override
  Widget build(BuildContext context) {
    final newTransactionProv = ref.watch(newTransactionProvider);

    final newTransactionIcon =
        newTransactionProv.newTransaction.transactionIcon;

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
                    categoryIconName,
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
