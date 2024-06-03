import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:daily_expense_tracker/widgets/new_transaction/new_transaction_complete_button.dart';
import 'package:daily_expense_tracker/widgets/new_transaction/new_transaction_icon_selection.dart';
import 'package:daily_expense_tracker/widgets/new_transaction/new_transaction_radio_buttons.dart';
import 'package:daily_expense_tracker/widgets/global_widgets/white_closing_modal_line.dart';
import 'package:daily_expense_tracker/providers/new_transaction_provider.dart';
import 'package:daily_expense_tracker/colors/custom_colors.dart';

const _topPaddingBetweenWidgets = 25.0;

InputDecoration _inputDecoration(String decorationLabel) {
  return InputDecoration(
    contentPadding: const EdgeInsets.all(12),
    labelText: decorationLabel,
    labelStyle: const TextStyle(
      color: Colors.white,
      fontSize: 18,
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
        width: 2,
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
        width: 1,
      ),
    ),
  );
}

class NewTransactionModalContent extends ConsumerStatefulWidget {
  const NewTransactionModalContent({super.key});

  @override
  ConsumerState<NewTransactionModalContent> createState() =>
      _NewTransactionModalContentState();
}

class _NewTransactionModalContentState
    extends ConsumerState<NewTransactionModalContent> {
  final _infosController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void initState() {
    final newTransaction = ref.read(newTransactionProvider).newTransaction;

    _infosController.text = newTransaction.transactionInfo.trim();
    _amountController.text = "${newTransaction.amount}";

    super.initState();
  }

  @override
  void dispose() {
    _infosController.dispose();
    _amountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(newTransactionProvider);

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        height: screenHeight * 0.75,
        width: double.infinity,
        padding: const EdgeInsets.all(25),
        decoration: const BoxDecoration(
          color: CustomColors.primaryBgColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24),
            topLeft: Radius.circular(24),
          ),
        ),
        child: Column(
          children: <Widget>[
            whiteClosingModalLine(screenWidth * 0.5),
            const Padding(
              padding: EdgeInsets.only(top: 35.0),
              child: Text(
                "Save New Transaction",
                textScaler: TextScaler.linear(1.1),
                style: TextStyle(
                  letterSpacing: 1.2,
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35),
              child: TextFormField(
                controller: _infosController,
                maxLength: 20,
                onChanged: (newNameValue) {
                  ref
                      .read(newTransactionProvider.notifier)
                      .setNewTransactionInfo(
                        newNameValue.trim(),
                      );
                },
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
                decoration: _inputDecoration("Transaction Infos"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: _topPaddingBetweenWidgets),
              child: TextFormField(
                controller: _amountController,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(
                    RegExp(r'\s'),
                  ),
                  FilteringTextInputFormatter.deny(
                    RegExp(","),
                  ),
                  FilteringTextInputFormatter.deny(
                    RegExp("-"),
                  ),
                ],
                maxLength: 20,
                keyboardType: TextInputType.number,
                onChanged: (newNameValue) {
                  if (double.tryParse(newNameValue) == null) {
                    return;
                  }

                  ref
                      .read(newTransactionProvider.notifier)
                      .setNewTransactionAmount(
                        double.parse(newNameValue),
                      );
                },
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
                decoration: _inputDecoration("Transaction Amount"),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: _topPaddingBetweenWidgets),
              child: NewTransactionIconSelection(),
            ),
            const Padding(
              padding: EdgeInsets.only(top: _topPaddingBetweenWidgets),
              child: NewTransactionRadioButtons(),
            ),
            const Spacer(),
            NewTransactionCompleteButton(
              onFormSubmitHandler: () {
                _infosController.text = "";
                _amountController.text = "";
              },
            ),
          ],
        ),
      ),
    );
  }
}
