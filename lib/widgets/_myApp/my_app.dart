import "package:flutter/material.dart";

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:daily_expense_tracker/widgets/global_widgets/bottom_nav_bar_row/bottom_nav_bar_row.dart';
import 'package:daily_expense_tracker/providers/bottom_nav_bar_provider.dart';
import 'package:daily_expense_tracker/colors/custom_colors.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final bottomNavBarProv = ref.watch(bottomNavBarProvider);

    final currentDisplayedScreen = bottomNavBarProv.currentDisplayedScreen;

    final screenHeight = MediaQuery.of(context).size.height;

    const bottomNavBarHeight = 70.0;

    return MaterialApp(
      title: "Daily Expense Tracker",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme().copyWith(
          actionsIconTheme: const IconThemeData().copyWith(
            color: Colors.white,
            size: 30,
          ),
          backgroundColor: CustomColors.primaryBgColor,
          foregroundColor: Colors.white,
          iconTheme: const IconThemeData().copyWith(
            color: Colors.white,
            size: 30,
          ),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        colorScheme: const ColorScheme.dark().copyWith(
          background: CustomColors.primaryBgColor,
        ),
        useMaterial3: true,
      ),
      home: Column(
        children: [
          SizedBox(
            height: screenHeight - bottomNavBarHeight,
            child: currentDisplayedScreen,
          ),
          const SizedBox(
            height: bottomNavBarHeight,
            child: BottomNavBarRow(),
          )
        ],
      ),
    );
  }
}
