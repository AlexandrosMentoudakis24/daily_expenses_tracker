import 'package:flutter/material.dart';

class SingleCategoryIconItem extends StatelessWidget {
  const SingleCategoryIconItem({
    required this.itemHeight,
    required this.itemWidth,
    required this.title,
    required this.icon,
    super.key,
  });

  final double itemHeight;
  final double itemWidth;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: itemHeight,
      width: itemWidth,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          const Spacer(),
          Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
        ],
      ),
    );
  }
}
