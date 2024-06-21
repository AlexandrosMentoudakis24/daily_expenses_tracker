import 'package:daily_expense_tracker/providers/user_account_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:daily_expense_tracker/widgets/global_widgets/white_closing_modal_line.dart';
import 'package:daily_expense_tracker/colors/custom_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddMoreFundsModalContent extends ConsumerStatefulWidget {
  const AddMoreFundsModalContent({super.key});

  @override
  ConsumerState<AddMoreFundsModalContent> createState() =>
      _AddMoreFundsModalContentState();
}

class _AddMoreFundsModalContentState
    extends ConsumerState<AddMoreFundsModalContent> {
  final _addFundsTextController = TextEditingController();

  var _isEmptyTextField = false;
  var _hasError = false;

  void _addFunds() {
    try {
      final currentAddedAmount = double.tryParse(_addFundsTextController.text);

      if (currentAddedAmount! <= 0.0) throw Error();

      ref.read(loggedUserAccountProvider).addMoreFunds(currentAddedAmount);

      _addFundsTextController.text = "";

      Navigator.of(context).pop();
    } catch (err) {
      setState(() {
        _hasError = true;
      });
    }
  }

  String _eliminateZeros(String currentEnteredAmount) {
    if (currentEnteredAmount.isEmpty) return "";

    var splittedWord = currentEnteredAmount;

    if (currentEnteredAmount.contains(".")) {
      splittedWord = currentEnteredAmount.split(".")[0];
      var decimals = currentEnteredAmount.split(".")[1];

      splittedWord = "$splittedWord.$decimals";
    }

    while (splittedWord.startsWith("0")) {
      splittedWord = splittedWord.substring(1);
    }

    if (splittedWord.startsWith(".")) {
      splittedWord = "0$splittedWord";
    }

    return splittedWord;
  }

  @override
  void initState() {
    super.initState();

    _addFundsTextController.text = "0.0";
  }

  @override
  void dispose() {
    _addFundsTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4 +
            MediaQuery.of(context).viewInsets.bottom,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: const BoxDecoration(
          color: CustomColors.primaryBgColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: whiteClosingModalLine(
                MediaQuery.of(context).size.width * 0.5,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Text(
                "ADD MORE FUNDS",
                textScaler: TextScaler.linear(1.1),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  border: Border.all(
                    color: _hasError ? Colors.red : Colors.white,
                    width: 2,
                  ),
                ),
                child: TextField(
                  controller: _addFundsTextController,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    final constructedValue = _eliminateZeros(value.trim());

                    if (_hasError) {
                      setState(() {
                        _hasError = false;
                      });
                    }

                    _addFundsTextController.text = constructedValue;

                    if (!_isEmptyTextField && constructedValue.isNotEmpty) {
                      return;
                    }

                    setState(() {
                      _isEmptyTextField = constructedValue.isEmpty;
                    });
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(
                      RegExp(r'\s'),
                    ),
                    FilteringTextInputFormatter.deny(
                      RegExp(","),
                    ),
                    FilteringTextInputFormatter.deny(
                      RegExp("-"),
                    ),
                  ],
                  style: TextStyle(
                    color: _hasError ? Colors.red : Colors.white,
                    fontSize: 20,
                  ),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(
                      left: 30.0,
                      top: 8.0,
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          _addFundsTextController.text = "";
                          setState(() {
                            _isEmptyTextField = true;
                          });
                        },
                        child: Icon(
                          Icons.close,
                          color: _isEmptyTextField ? Colors.grey : Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: _addFunds,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.45,
                margin: const EdgeInsets.only(top: 40.0),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: const Text(
                  "ADD FUNDS",
                  textScaler: TextScaler.linear(1.1),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
