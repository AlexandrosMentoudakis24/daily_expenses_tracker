import 'package:flutter/material.dart';

class SingleCategoryIconItem extends StatelessWidget {
  const SingleCategoryIconItem({
    required this.itemHeight,
    required this.itemWidth,
    required this.title,
    required this.icon,
    required this.textColor,
    super.key,
  });

  final double itemHeight;
  final double itemWidth;
  final String title;
  final IconData icon;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: itemHeight,
      width: itemWidth,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: textColor,
            width: 2,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            title,
            textScaler: const TextScaler.linear(1.1),
            style: TextStyle(
              color: textColor,
              fontSize: 20,
            ),
          ),
          const Spacer(),
          Icon(
            icon,
            color: textColor,
            size: 30,
          ),
        ],
      ),
    );
  }
}
