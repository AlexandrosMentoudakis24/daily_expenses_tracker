import 'package:flutter/material.dart';

class EmptyScreenContent extends StatelessWidget {
  const EmptyScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20.0),
      alignment: Alignment.center,
      child: Column(
        children: [
          Image.asset(
            "assets/images/empty_list_img.png",
          ),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "We were not able to find any resources in here...",
              textAlign: TextAlign.center,
              textScaler: TextScaler.linear(1.1),
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
