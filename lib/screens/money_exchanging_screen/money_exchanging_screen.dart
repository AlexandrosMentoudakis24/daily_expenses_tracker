import 'package:daily_expense_tracker/widgets/global_widgets/empty_screen_content.dart';
import 'package:flutter/material.dart';

import 'package:daily_expense_tracker/widgets/money_exchanging_screen/circle_users_row_container.dart';

class MoneyExchangeScreen extends StatelessWidget {
  const MoneyExchangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isEmptyList = true;

    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: SizedBox(
                height: 90,
                width: constraints.maxWidth,
                child: const CircleUsersRowContainer(),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight - 90,
              width: constraints.maxWidth,
              child: isEmptyList
                  ? const EmptyScreenContent()
                  : ListView.builder(
                      itemCount: 0,
                      itemBuilder: (context, index) {
                        return null;
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
