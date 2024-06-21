import 'package:flutter/material.dart';

class CircleUserAvatar extends StatelessWidget {
  const CircleUserAvatar({
    bool? hasImage,
    this.imageUrl,
    required this.firstName,
    required this.icon,
    super.key,
  }) : hasImage = false;

  final bool? hasImage;
  final String? imageUrl;
  final String firstName;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: hasImage!
                    ? Image.network(
                        fit: BoxFit.contain,
                        imageUrl!,
                      )
                    : Icon(
                        icon,
                        color: Colors.white,
                        size: 30,
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                firstName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
