import 'package:flutter/material.dart';

class EmptyScreenContent extends StatelessWidget {
  const EmptyScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20.0),
      alignment: Alignment.center,
      child: Image.asset(
        "assets/images/empty_list_img.png",
      ),
    );
  }
}
