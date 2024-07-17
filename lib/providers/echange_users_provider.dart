import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:daily_expense_tracker/models/exchange_user.dart';

class ExchangeUsersNotifier extends ChangeNotifier {
  ExchangeUsersNotifier() : existingExchangeUsers = [];

  List<ExchangeUser> existingExchangeUsers;

  void setExchangeUsers(List<ExchangeUser> newExchangeUsers) {
    existingExchangeUsers = [...newExchangeUsers];

    notifyListeners();
  }

  void clearExchangeUsers() {
    existingExchangeUsers = [];

    notifyListeners();
  }

  void addNewExchangeUser(ExchangeUser newExchangeUser) {
    existingExchangeUsers = [newExchangeUser, ...existingExchangeUsers];

    notifyListeners();
  }
}

final exchangeUsersProvider =
    ChangeNotifierProvider<ExchangeUsersNotifier>((ref) {
  return ExchangeUsersNotifier();
});
