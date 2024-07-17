import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:basic_utils/basic_utils.dart';

import 'package:daily_expense_tracker/widgets/global_widgets/white_closing_modal_line.dart';
import 'package:daily_expense_tracker/providers/echange_users_provider.dart';
import 'package:daily_expense_tracker/models/exchange_user.dart';
import 'package:daily_expense_tracker/colors/custom_colors.dart';

InputDecoration _inputDecoration(String decorationLabel) {
  return InputDecoration(
    contentPadding: const EdgeInsets.all(12),
    labelText: decorationLabel,
    labelStyle: const TextStyle(
      color: Colors.white,
      fontSize: 18,
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
        width: 2,
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
        width: 1,
      ),
    ),
  );
}

class AddNewExchangeUserModalContent extends ConsumerStatefulWidget {
  const AddNewExchangeUserModalContent({super.key});

  @override
  ConsumerState<AddNewExchangeUserModalContent> createState() =>
      _AddNewExchangeUserModalContentState();
}

class _AddNewExchangeUserModalContentState
    extends ConsumerState<AddNewExchangeUserModalContent> {
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();

  void _saveNewExchangeUser() {
    final firstName = _firstNameTextController.text;
    final lastName = _lastNameTextController.text;

    if (firstName.isEmpty || lastName.isEmpty) return;

    final extistingUserLength =
        ref.read(exchangeUsersProvider).existingExchangeUsers.length;

    final newExchangeUser = ExchangeUser(
        userId: "${extistingUserLength + 1}",
        firstName: firstName,
        lastName: lastName);

    ref
        .read(exchangeUsersProvider.notifier)
        .addNewExchangeUser(newExchangeUser);

    _firstNameTextController.text = "";
    _lastNameTextController.text = "";

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _firstNameTextController.dispose();
    _lastNameTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        height: screenHeight * 0.5 + MediaQuery.of(context).viewInsets.bottom,
        width: screenWidth,
        padding: EdgeInsets.fromLTRB(
          25,
          25,
          25,
          25 + MediaQuery.of(context).viewInsets.bottom * 1,
        ),
        decoration: const BoxDecoration(
          color: CustomColors.primaryBgColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24),
            topLeft: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            whiteClosingModalLine(screenWidth * 0.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _firstNameTextController.text = "";
                    _lastNameTextController.text = "";
                  },
                  child: const Text(
                    "Clear",
                    textScaler: TextScaler.linear(1.1),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 35.0),
              child: Text(
                "Save New Exchange User",
                textScaler: TextScaler.linear(1.1),
                style: TextStyle(
                  letterSpacing: 1.2,
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35),
              child: TextFormField(
                controller: _firstNameTextController,
                maxLength: 20,
                onChanged: (newValue) {
                  final enteredValue = newValue.trim();

                  var formattedValue = StringUtils.capitalize(newValue);

                  if (enteredValue.length >= 2) {
                    formattedValue =
                        "${StringUtils.capitalize(enteredValue.substring(0, 1))}${enteredValue.substring(1)}";
                  }

                  _firstNameTextController.text = formattedValue;
                },
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
                decoration: _inputDecoration("First Name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: TextFormField(
                controller: _lastNameTextController,
                maxLength: 20,
                onChanged: (newValue) {
                  final enteredValue = newValue.trim();

                  var formattedValue = StringUtils.capitalize(newValue);

                  if (enteredValue.length >= 2) {
                    formattedValue =
                        "${StringUtils.capitalize(enteredValue.substring(0, 1))}${enteredValue.substring(1)}";
                  }

                  _lastNameTextController.text = formattedValue;
                },
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
                decoration: _inputDecoration("Last Name"),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: _saveNewExchangeUser,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(90),
                ),
                child: const Text(
                  "Save User",
                  textScaler: TextScaler.linear(1.2),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
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
