import 'package:flutter/material.dart';

import 'package:daily_expense_tracker/screens/single_user_exchange_screen/single_user_exchange_screen.dart';
import 'package:daily_expense_tracker/widgets/global_widgets/circle_user_avatar/circle_user_avatar.dart';
import 'package:daily_expense_tracker/widgets/money_exchanging_screen/add_new_exchange_button.dart';
import 'package:daily_expense_tracker/models/exchange_user.dart';

class CircleUsersRowContainer extends StatelessWidget {
  const CircleUsersRowContainer({
    required this.existingExchangeUsers,
    super.key,
  });

  final List<ExchangeUser> existingExchangeUsers;

  @override
  Widget build(BuildContext context) {
    final isEmptyList = existingExchangeUsers.isEmpty;

    return LayoutBuilder(
      builder: (context, constraints) => Container(
        margin: const EdgeInsets.only(top: 15),
        height: constraints.maxHeight,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.white,
              width: 2,
            ),
            bottom: BorderSide(
              color: Colors.white,
              width: 2,
            ),
          ),
        ),
        width: constraints.maxWidth,
        child: isEmptyList
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Start",
                    textScaler: TextScaler.linear(1.1),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: AddNewExchangeButton(),
                  ),
                  Text(
                    "Exchanging Now!",
                    textScaler: TextScaler.linear(1.1),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                    ),
                  ),
                ],
              )
            : Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Container(
                      width: constraints.maxWidth * 0.2,
                      alignment: Alignment.center,
                      child: const AddNewExchangeButton(),
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth * 0.8,
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: existingExchangeUsers.length,
                      itemBuilder: (context, index) {
                        final currentExistingExchangeUser =
                            existingExchangeUsers[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SingleUserExchangeScreen(
                                  exchangeUser: currentExistingExchangeUser,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                              top: 5,
                              left: 5,
                            ),
                            height: 80,
                            width: 140,
                            child: CircleUserAvatar(
                              userId: currentExistingExchangeUser.userId,
                              firstName: currentExistingExchangeUser.firstName,
                              lastName: currentExistingExchangeUser.lastName,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
