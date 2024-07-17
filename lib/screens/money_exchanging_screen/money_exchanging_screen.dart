import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:daily_expense_tracker/screens/single_user_exchange_screen/single_user_exchange_screen.dart';
import 'package:daily_expense_tracker/widgets/money_exchanging_screen/circle_users_row_container.dart';
import 'package:daily_expense_tracker/widgets/global_widgets/empty_screen_content.dart';
import 'package:daily_expense_tracker/providers/echange_users_provider.dart';

class MoneyExchangeScreen extends ConsumerStatefulWidget {
  const MoneyExchangeScreen({super.key});

  @override
  ConsumerState<MoneyExchangeScreen> createState() =>
      _MoneyExchangeScreenState();
}

class _MoneyExchangeScreenState extends ConsumerState<MoneyExchangeScreen> {
  void onAddNewUserHandler(String newUserFirstName, String newUserLastName) {}

  @override
  Widget build(BuildContext context) {
    final exchangeUsersProv = ref.watch(exchangeUsersProvider);
    final existingExchangeUsers = exchangeUsersProv.existingExchangeUsers;

    final isEmptyList = existingExchangeUsers.isEmpty;

    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: SizedBox(
                height: isEmptyList ? 100 : 130,
                width: constraints.maxWidth,
                child: CircleUsersRowContainer(
                  existingExchangeUsers: existingExchangeUsers,
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight - 130,
              width: constraints.maxWidth,
              child: isEmptyList
                  ? const EmptyScreenContent()
                  : ListView.builder(
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
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Row(
                              children: <Widget>[
                                const Flexible(
                                  flex: 1,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 45,
                                  ),
                                ),
                                Flexible(
                                  flex: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            currentExistingExchangeUser
                                                .firstName,
                                            textScaler:
                                                const TextScaler.linear(1.1),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 20,
                                            ),
                                          ),
                                          Text(
                                            currentExistingExchangeUser
                                                .lastName,
                                            textScaler:
                                                const TextScaler.linear(1.1),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
