// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:riandgo2/utils/utils.dart';

class DefaultElevatedButton extends StatelessWidget {
  const DefaultElevatedButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.height = 70,
    this.width = 320,
    this.padding = const EdgeInsets.all(10),
    this.borderRadius = 5,
  }) : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final double height;
  final double width;
  final EdgeInsets padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(title),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonsColor,
          textStyle: AppTypography.font20,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)),
        ),
      ),
    );
  }
}
