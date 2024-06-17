import 'package:daily_expense_tracker/widgets/money_lending_screen/circle_users_row_container.dart';
import 'package:flutter/material.dart';

import 'package:daily_expense_tracker/widgets/global_widgets/circle_user_avatar/circle_user_avatar.dart';

class MoneyExchangeScreen extends StatelessWidget {
  const MoneyExchangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 90,
                width: constraints.maxWidth,
                child: const CircleUsersRowContainer(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
