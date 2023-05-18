// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

// Project imports:
import 'package:riandgo2/utils/utils.dart';

class DefaultTextButton extends StatelessWidget {
  const DefaultTextButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.height = 70,
    this.width = 320,
    required this.textStyle,
  }) : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final double height;
  final double width;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: textStyle,
        ),
      ),
    );
  }
}