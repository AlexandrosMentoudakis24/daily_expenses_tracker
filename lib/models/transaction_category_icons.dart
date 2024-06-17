import 'package:flutter/material.dart';

enum TransactionCategory {
  salary,
  superMarket,
  entertainment,
  fastFood,
  cinema,
}

const transactionCategoryIcons = {
  TransactionCategory.superMarket: Icons.local_grocery_store_outlined,
  TransactionCategory.entertainment: Icons.local_drink,
  TransactionCategory.fastFood: Icons.fastfood,
  TransactionCategory.cinema: Icons.tv,
  TransactionCategory.salary: Icons.account_balance_wallet,
};
