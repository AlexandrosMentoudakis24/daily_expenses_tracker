import 'package:daily_expense_tracker/screens/money_exchange_screen/money_exchange_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:daily_expense_tracker/screens/categories_screen.dart/categories_screen.dart';
import 'package:daily_expense_tracker/screens/calendar_screen/calendar_screen.dart';
import 'package:daily_expense_tracker/screens/home_screen/home_screen.dart';

const List<Map<String, dynamic>> availableScreens = [
  {
    "title": "home",
    "screen": HomeScreen(),
    "icon": Icons.home,
  },
  {
    "title": "categories",
    "screen": CategoriesScreen(),
    "icon": Icons.bar_chart,
  },
  {
    "title": "wallet",
    "screen": MoneyExchangeScreen(),
    "icon": Icons.wallet,
  },
  {
    "title": "calendar",
    "screen": CalendarScreen(),
    "icon": Icons.calendar_month,
  }
];

class BottomNavBarNotifier extends ChangeNotifier {
  BottomNavBarNotifier()
      : currentDisplayedScreen = const HomeScreen(),
        title = "home";

  Widget currentDisplayedScreen;
  String title;

  void setNewDisplayedScreen(Widget newDisplayedScreen, String newTitle) {
    currentDisplayedScreen = newDisplayedScreen;
    title = newTitle;

    notifyListeners();
  }
}

final bottomNavBarProvider =
    ChangeNotifierProvider<BottomNavBarNotifier>((ref) {
  return BottomNavBarNotifier();
});
