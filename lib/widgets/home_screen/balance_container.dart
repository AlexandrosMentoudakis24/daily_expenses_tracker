import 'package:daily_expense_tracker/colors/custom_colors.dart';
import 'package:daily_expense_tracker/widgets/modals/modal_contents.dart/add_more_funds_modal_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:daily_expense_tracker/providers/user_account_provider.dart';

class BalanceContainer extends ConsumerWidget {
  const BalanceContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loggedUserAccountProv = ref.watch(loggedUserAccountProvider);

    final currentBalance = loggedUserAccountProv.loggedAccount.balance;

    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth,
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              width: screenWidth * 0.85,
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
                      fontSize: 17,
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
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: screenWidth * 0.15,
            margin: const EdgeInsets.only(left: 5.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: CustomColors.incomeBarFillColor,
                width: 1.5,
              ),
            ),
            child: IconButton(
              onPressed: () async {
                await showModalBottomSheet(
                  isScrollControlled: true,
                  isDismissible: false,
                  context: context,
                  builder: (context) => const AddMoreFundsModalContent(),
                );
              },
              icon: const Icon(
                Icons.add,
                color: CustomColors.incomeBarFillColor,
                size: 38,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
