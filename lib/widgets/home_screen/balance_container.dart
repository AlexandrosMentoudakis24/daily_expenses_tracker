import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:daily_expense_tracker/providers/user_account_provider.dart';

class BalanceContainer extends ConsumerWidget {
  const BalanceContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loggedUserAccountProv = ref.watch(loggedUserAccountProvider);

    final currentBalance = loggedUserAccountProv.loggedAccount.balance;

    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(180),
        color: Colors.black,
      ),
      child: Row(
        children: [
          const Text(
            "Current Balance:",
            textScaler: TextScaler.linear(1.1),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Text(
              textScaler: const TextScaler.linear(1.1),
              "$currentBalance \$",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 19,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
