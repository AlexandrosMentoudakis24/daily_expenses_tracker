import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:daily_expense_tracker/providers/bottom_nav_bar_provider.dart';
import 'package:daily_expense_tracker/colors/custom_colors.dart';

class BottomNavBarRow extends ConsumerStatefulWidget {
  const BottomNavBarRow({
    super.key,
  });

  @override
  ConsumerState<BottomNavBarRow> createState() => _BottomNavBarRowState();
}

class _BottomNavBarRowState extends ConsumerState<BottomNavBarRow> {
  @override
  Widget build(BuildContext context) {
    final bottomNavBarProv = ref.watch(bottomNavBarProvider);

    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
      ),
      child: Row(
        children: [
          ...availableScreens.map(
            (screenItem) {
              final currentScreenTitle = screenItem["title"];

              final isActive = bottomNavBarProv.title == currentScreenTitle;

              return GestureDetector(
                onTap: () {
                  ref.read(bottomNavBarProvider.notifier).setNewDisplayedScreen(
                        screenItem["screen"],
                        currentScreenTitle,
                      );
                },
                child: Container(
                  color: CustomColors.primaryBgColor,
                  height: double.infinity,
                  width: screenWidth * 1 / availableScreens.length,
                  child: Icon(
                    screenItem["icon"],
                    size: 37,
                    color: isActive ? Colors.white : Colors.grey,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
