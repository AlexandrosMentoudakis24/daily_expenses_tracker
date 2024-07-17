import 'package:flutter/material.dart';

import 'package:basic_utils/basic_utils.dart';

import 'package:daily_expense_tracker/models/exchange_user.dart';

class SingleUserExchangeScreen extends StatefulWidget {
  const SingleUserExchangeScreen({
    required this.exchangeUser,
    super.key,
  });

  final ExchangeUser exchangeUser;

  @override
  State<SingleUserExchangeScreen> createState() =>
      _SingleUserExchangeScreenState();
}

class _SingleUserExchangeScreenState extends State<SingleUserExchangeScreen> {
  @override
  Widget build(BuildContext context) {
    final userFirstName = widget.exchangeUser.firstName;
    final userLastName = widget.exchangeUser.lastName;

    final formattedUserFullName =
        "${StringUtils.capitalize(userFirstName)} ${StringUtils.capitalize(userLastName)}";

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData().copyWith(
          size: 30,
          color: Colors.white,
        ),
        title: Text(
          formattedUserFullName,
        ),
      ),
    );
  }
}
