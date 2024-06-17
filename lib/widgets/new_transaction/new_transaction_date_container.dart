import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:daily_expense_tracker/providers/new_transaction_provider.dart';

class NewTransactionDateContainer extends ConsumerStatefulWidget {
  const NewTransactionDateContainer({super.key});

  @override
  ConsumerState<NewTransactionDateContainer> createState() =>
      _NewTransactionDateContainerState();
}

class _NewTransactionDateContainerState
    extends ConsumerState<NewTransactionDateContainer> {
  String? _dateInputText;

  @override
  void initState() {
    super.initState();

    final createdAt = ref.read(newTransactionProvider).newTransaction.createdAt;

    _dateInputText = "Date: ${createdAt.toString().split(' ')[0]}";
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(newTransactionProvider);

    return LayoutBuilder(
      builder: (context, constraints) => Container(
        width: constraints.maxWidth,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: constraints.maxWidth * 0.8,
              child: Text(
                _dateInputText!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  initialDate: DateTime.now(),
                  lastDate: DateTime.now(),
                );

                if (pickedDate == null) return;

                ref
                    .read(newTransactionProvider.notifier)
                    .setNewTransactionDate(pickedDate);

                _dateInputText = "Date: ${pickedDate.toString().split(' ')[0]}";
              },
              child: const Icon(
                Icons.calendar_today,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
