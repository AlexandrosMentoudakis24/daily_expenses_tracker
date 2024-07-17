import 'package:flutter/material.dart';

enum TransactionCategory {
  salary,
  superMarket,
  entertainment,
  fastFood,
  cinema,
  other,
}

const transactionCategoryIcons = {
  TransactionCategory.superMarket: Icons.local_grocery_store_outlined,
  TransactionCategory.entertainment: Icons.local_drink,
  TransactionCategory.fastFood: Icons.fastfood,
  TransactionCategory.cinema: Icons.tv,
  TransactionCategory.salary: Icons.account_balance_wallet,
  TransactionCategory.other: Icons.indeterminate_check_box,
};
