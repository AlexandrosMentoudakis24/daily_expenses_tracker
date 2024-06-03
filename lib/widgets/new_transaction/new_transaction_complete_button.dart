import 'package:daily_expense_tracker/modals/modal_contents.dart/not_enough_balance_modal_content.dart';
import 'package:daily_expense_tracker/providers/new_transaction_provider.dart';
import 'package:daily_expense_tracker/providers/transactions_provider.dart';
import 'package:daily_expense_tracker/providers/user_account_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      final newTransactionProvNoti = ref.read(newTransactionProvider.notifier);

      final newTransaction = newTransactionProvNoti.newTransaction;

      ref
          .read(loggedUserAccountProvider.notifier)
          .completeNewTransction(newTransaction);

      ref.read(transactionsProvider.notifier).addNewTransaction(newTransaction);

      widget.onFormSubmitHandler();

      newTransactionProvNoti.clearNewTransaction();
    } catch (err) {
      setState(() {
        _isLoading = false;
      });

      await showAdaptiveDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => const NotEnoughBalanceModalContent(),
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
          backgroundColor: Colors.black,
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
                color: Colors.white,
                fontSize: 22,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Icon(
                Icons.done_all,
                size: 25,
                color: Colors.white,
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
