import 'package:daily_expense_tracker/widgets/global_widgets/circle_user_avatar/circle_user_avatar.dart';
import 'package:flutter/material.dart';

class CircleUsersRowContainer extends StatelessWidget {
  const CircleUsersRowContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        height: constraints.maxHeight,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 2,
            ),
          ),
        ),
        width: constraints.maxWidth,
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(left: 5),
                height: 80,
                width: 80,
                child: const CircleUserAvatar(
                  icon: Icons.add,
                  firstName: "Search",
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight,
              width: constraints.maxWidth - 90 - 5,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(left: 5),
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
