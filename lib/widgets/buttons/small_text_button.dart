import 'package:flutter/material.dart';

// Project imports:
import 'package:riandgo2/utils/utils.dart';

class SmallTextButton extends StatelessWidget {
  const SmallTextButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.height = 70,
    this.width = 320,
  }) : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: AppTypography.font12orange,
        ),
      ),
    );
  }
}