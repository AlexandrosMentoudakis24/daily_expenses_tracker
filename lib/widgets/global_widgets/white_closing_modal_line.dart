import 'package:flutter/material.dart';

Widget whiteClosingModalLine(double providedWidth) {
  return Container(
    width: providedWidth,
    height: 8,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(180),
    ),
  );
}
