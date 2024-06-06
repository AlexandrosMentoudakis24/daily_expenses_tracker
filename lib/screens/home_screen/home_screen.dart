import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:daily_expense_tracker/widgets/modals/modal_contents.dart/new_transaction_modal_content.dart';
import 'package:daily_expense_tracker/widgets/global_widgets/empty_screen_content.dart';
import 'package:daily_expense_tracker/widgets/global_widgets/transaction_list.dart';
import 'package:daily_expense_tracker/widgets/home_screen/balance_container.dart';
import 'package:daily_expense_tracker/providers/transactions_provider.dart';
import 'package:daily_expense_tracker/models/transaction.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late List<Transaction> transactionsList;

  var _circleIconButtonSize = 60.0;
  double? _circleIconButtonX;
  double? _circleIconButtonY;

  void _onAddNewTransactionPressed() async {
    await showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: (context) => const NewTransactionModalContent(),
    );
  }

  Future<void> _fetchTransactions() async {
    await ref.read(transactionsProvider.notifier).fetchAllTransactions();

    if (!mounted) return;
  }

  void _changeButtonsPosition(Offset newOffSet) {
    setState(() {
      _circleIconButtonX = newOffSet.dx;
      _circleIconButtonY = newOffSet.dy;
    });
  }

  void _finalizeButtonsPosition(Offset newOffSet) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final isRightPosition = newOffSet.dx >= screenWidth / 2.0;

    final isFullTop = newOffSet.dy <= 20;
    final isFullBottom = newOffSet.dy >= screenHeight - _circleIconButtonSize;

    _circleIconButtonY = newOffSet.dy;

    if (isFullTop) {
      _circleIconButtonY = _circleIconButtonSize;
    }

    if (isFullBottom) {
      _circleIconButtonY = screenHeight - _circleIconButtonSize * 2.5;
    }

    setState(() {
      _circleIconButtonX = isRightPosition
          ? screenWidth - _circleIconButtonSize
          : _circleIconButtonSize / 2 - 5;
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(milliseconds: 1),
      _fetchTransactions,
    );
  }

  @override
  Widget build(BuildContext context) {
    final transactionsProv = ref.watch(transactionsProvider);

    transactionsList = [...transactionsProv.existingTransactions];

    final isEmptyList = transactionsList.isEmpty;

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    _circleIconButtonX =
        _circleIconButtonX ?? screenWidth - _circleIconButtonSize;
    _circleIconButtonY =
        _circleIconButtonY ?? screenHeight - _circleIconButtonSize * 2.5;

    return RefreshIndicator(
      onRefresh: _fetchTransactions,
      child: Scaffold(
          floatingActionButton: SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: Stack(
              children: [
                Positioned(
                  top: _circleIconButtonY,
                  left: _circleIconButtonX,
                  child: GestureDetector(
                    onTap: _onAddNewTransactionPressed,
                    onLongPressMoveUpdate: (details) {
                      final Offset newOffSet = Offset(
                        details.globalPosition.dx,
                        details.globalPosition.dy,
                      );

                      _changeButtonsPosition(newOffSet);
                    },
                    onLongPressStart: (details) {
                      setState(() {
                        _circleIconButtonSize = 55;
                      });
                    },
                    onLongPressEnd: (LongPressEndDetails details) {
                      final Offset newOffSet = Offset(
                        details.globalPosition.dx,
                        details.globalPosition.dy,
                      );

                      setState(() {
                        _circleIconButtonSize = 60;
                      });

                      _finalizeButtonsPosition(newOffSet);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: _circleIconButtonSize,
                      width: _circleIconButtonSize,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 70, 167, 246),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: const Text(
              "Daily Expense Tracker",
            ),
            actions: const <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.search,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const BalanceContainer(),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Transactions",
                        textScaler: TextScaler.linear(1.1),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "See all",
                          textScaler: TextScaler.linear(1.1),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  isEmptyList
                      ? const EmptyScreenContent()
                      : TransactionList(
                          transactionsList: [
                            ...transactionsList,
                          ],
                        ),
                ],
              ),
            ),
          )),
    );
  }
}
