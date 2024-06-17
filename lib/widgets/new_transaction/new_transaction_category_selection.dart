import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:daily_expense_tracker/widgets/modals/modal_contents.dart/new_category_icon_modal_content.dart';
import 'package:daily_expense_tracker/utils/converters/convert_enum_values.dart';
import 'package:daily_expense_tracker/providers/new_transaction_provider.dart';
import 'package:daily_expense_tracker/models/transaction_category_icons.dart';

class NewTransactionCategorySelection extends ConsumerStatefulWidget {
  const NewTransactionCategorySelection({super.key});

  @override
  ConsumerState<NewTransactionCategorySelection> createState() =>
      _NewTransactionCategorySelectionState();
}

class _NewTransactionCategorySelectionState
    extends ConsumerState<NewTransactionCategorySelection> {
  var transactionCategory = TransactionCategory.values[0];

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

    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        width: constraints.maxWidth,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: constraints.maxWidth * 0.75,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: constraints.maxWidth * 0.75 * 0.8,
                      child: Text(
                        convertEnumToString(transactionCategory),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    newTransactionIcon,
                    color: Colors.white,
                    size: 30,
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
      ),
    );
  }
}
