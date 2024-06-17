import 'package:flutter/material.dart';

import 'package:daily_expense_tracker/widgets/modals/modal_contents.dart/new_transaction_modal_content.dart';
import 'package:daily_expense_tracker/widgets/home_screen/search_bar_container.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({
    required this.bodyContent,
    super.key,
  });

  final Widget bodyContent;

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  var _isSearchBarExpanded = false;

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
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final isKeyboardFocused = MediaQuery.of(context).viewInsets.bottom > 0.0;

    _circleIconButtonX =
        _circleIconButtonX ?? screenWidth - _circleIconButtonSize;
    _circleIconButtonY =
        _circleIconButtonY ?? screenHeight - _circleIconButtonSize * 2.5;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();

        setState(() {
          _isSearchBarExpanded = false;
        });
      },
      child: Scaffold(
        floatingActionButton: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: isKeyboardFocused
              ? null
              : Stack(
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
          centerTitle: !_isSearchBarExpanded,
          title: _isSearchBarExpanded
              ? SearchBarContainer(
                  isFocused: _isSearchBarExpanded,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Daily Expense Tracker",
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _isSearchBarExpanded = true;
                        });
                      },
                      icon: const Icon(
                        Icons.search,
                      ),
                    ),
                  ],
                ),
        ),
        body: widget.bodyContent,
      ),
    );
  }
}
