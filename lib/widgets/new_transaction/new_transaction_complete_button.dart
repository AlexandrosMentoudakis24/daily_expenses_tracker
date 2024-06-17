import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:daily_expense_tracker/widgets/modals/modal_contents.dart/not_enough_balance_modal_content.dart';
import 'package:daily_expense_tracker/providers/new_transaction_provider.dart';
import 'package:daily_expense_tracker/providers/transactions_provider.dart';
import 'package:daily_expense_tracker/providers/user_account_provider.dart';
import 'package:daily_expense_tracker/models/transaction.dart';

class NewTransactionCompleteButton extends ConsumerStatefulWidget {
  const NewTransactionCompleteButton({
    required this.onFormSubmitHandler,
    super.key,
  });

  final Function() onFormSubmitHandler;

  @override
  ConsumerState<NewTransactionCompleteButton> createState() =>
      _NewTransactionCompleteButtonState();
}

class _NewTransactionCompleteButtonState
    extends ConsumerState<NewTransactionCompleteButton> {
  var _isLoading = false;

  void _saveTransaction() async {
    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      _isLoading = true;
    });

    try {
      final loggedUserAccountProvNoti =
          ref.read(loggedUserAccountProvider.notifier);

      final balance = loggedUserAccountProvNoti.loggedAccount.balance;

      final newTransactionProvNoti = ref.read(newTransactionProvider.notifier);

      final transactionType =
          newTransactionProvNoti.newTransaction.transactionType;
      final transactionAmount = newTransactionProvNoti.newTransaction.amount;

      if (transactionType == TransactionType.expense &&
          balance - transactionAmount < 0.0) {
        throw ("Insufficient account balance!");
      }

      final newTransaction = await newTransactionProvNoti.saveTransactionToDB();

      if (newTransaction == null) throw Error();

      ref.read(transactionsProvider.notifier).addNewTransaction(newTransaction);

      loggedUserAccountProvNoti.completeNewTransaction(newTransaction);

      widget.onFormSubmitHandler();

      newTransactionProvNoti.clearNewTransaction();

      if (!mounted) return;

      Navigator.of(context).pop();
    } catch (err) {
      setState(() {
        _isLoading = false;
      });

      if (!mounted) return;

      if (err == "Insufficient account balance!") {
        await showAdaptiveDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) => const NotEnoughBalanceModalContent(),
        );

        return;
      }

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).clearSnackBars();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Failed to save transaction!",
          ),
          duration: Duration(
            milliseconds: 3000,
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    const Widget loadingScreenContent = SizedBox(
      height: 35,
      width: 35,
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );

    Widget screenContent = SizedBox(
      height: 55,
      width: screenWidth * 0.55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          splashFactory: NoSplash.splashFactory,
        ),
        onPressed: _saveTransaction,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Complete",
              textScaler: TextScaler.linear(1.1),
              style: TextStyle(
                letterSpacing: 1.1,
                color: Colors.black,
                fontSize: 22,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Icon(
                Icons.done_all,
                size: 25,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );

    if (_isLoading) {
      screenContent = loadingScreenContent;
    }

    return screenContent;
  }
}
