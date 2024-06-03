import 'package:daily_expense_tracker/providers/user_account_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotEnoughBalanceModalContent extends ConsumerWidget {
  const NotEnoughBalanceModalContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentBalance =
        ref.read(loggedUserAccountProvider).loggedAccount.balance;

    return AlertDialog(
      backgroundColor: Colors.black,
      title: const Text(
        "Insufficient Balance!",
        style: TextStyle(
          color: Colors.blue,
          fontSize: 25,
        ),
      ),
      content: SizedBox(
        height: 220,
        child: Column(
          children: [
            const Text(
              "Your account's balance appears to be lower than the transaction's expected ammount!\n",
              textAlign: TextAlign.left,
              textScaler: TextScaler.linear(1.1),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const Text(
              "Your current balance is:",
              textAlign: TextAlign.center,
              textScaler: TextScaler.linear(1.1),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            Text(
              "$currentBalance \$",
              textAlign: TextAlign.center,
              textScaler: const TextScaler.linear(1.2),
              style: const TextStyle(
                color: Colors.green,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text(
            "Okay",
            textScaler: TextScaler.linear(1.1),
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
