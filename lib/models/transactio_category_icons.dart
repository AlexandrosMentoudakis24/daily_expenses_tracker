import 'package:flutter/material.dart';

enum TransactionCategories {
  superMarket,
  entertainment,
  fastFood,
  cinema,
  salary,
}

const transactionCategoryIcons = {
  TransactionCategories.superMarket: Icons.local_grocery_store_outlined,
  TransactionCategories.entertainment: Icons.local_drink,
  TransactionCategories.fastFood: Icons.fastfood,
  TransactionCategories.cinema: Icons.tv,
  TransactionCategories.salary: Icons.account_balance_wallet,
};
