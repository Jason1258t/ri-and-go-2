// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:riandgo2/utils/fonts.dart';

// Project imports:

class SaveTextButton extends StatelessWidget {
  const SaveTextButton({
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
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFC46C),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17.0),
          ),
          // shadowColor: Color(0xffE28F8F),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: AppTypography.font20_white,
        ),
      ),
    );
  }
}