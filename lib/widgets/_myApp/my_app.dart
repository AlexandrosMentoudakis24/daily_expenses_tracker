import 'package:daily_expense_tracker/models/transaction.dart';
import "package:flutter/material.dart";

import 'package:daily_expense_tracker/screens/home_screen/home_screen.dart';
import 'package:daily_expense_tracker/colors/custom_colors.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
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
      home: const HomeScreen(),
    );
  }
}
