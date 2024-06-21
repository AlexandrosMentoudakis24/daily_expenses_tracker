import 'package:daily_expense_tracker/widgets/money_exchanging_screen/add_new_exchange_button.dart';
import 'package:flutter/material.dart';

import 'package:daily_expense_tracker/widgets/global_widgets/circle_user_avatar/circle_user_avatar.dart';

class CircleUsersRowContainer extends StatelessWidget {
  const CircleUsersRowContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final isEmptyList = true;

    return LayoutBuilder(
      builder: (context, constraints) => Container(
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
                    "Exchanging!",
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
                      // decoration: const BoxDecoration(
                      // border: Border(
                      //   right: BorderSide(
                      //     color: Colors.white,
                      //     width: 2,
                      //   ),
                      // ),
                      // ),
                      child: const AddNewExchangeButton(),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth * 0.8,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(
                            top: 5,
                            left: 5,
                          ),
                          height: 80,
                          width: 90,
                          child: const CircleUserAvatar(
                            icon: Icons.person,
                            firstName: "Alexandros",
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
