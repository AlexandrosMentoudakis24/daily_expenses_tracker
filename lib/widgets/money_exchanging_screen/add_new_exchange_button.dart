import 'package:daily_expense_tracker/widgets/modals/modal_contents.dart/add_new_exchange_user_modal_content.dart';
import 'package:flutter/material.dart';

class AddNewExchangeButton extends StatelessWidget {
  const AddNewExchangeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showModalBottomSheet(
          isScrollControlled: true,
          isDismissible: false,
          context: context,
          builder: (context) => const AddNewExchangeUserModalContent(),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}
