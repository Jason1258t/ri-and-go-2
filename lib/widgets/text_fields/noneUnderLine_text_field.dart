// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:riandgo2/utils/utils.dart';

class NoneUnderLineTextField extends StatefulWidget {
  const NoneUnderLineTextField({
    Key? key,
    required this.controller,
    required this.keyboardType,
    this.height = 80,
    this.width = double.infinity,
    this.padding = const EdgeInsets.all(10),
    this.maxLines = 1,
    this.hintText = '',
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType keyboardType;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final double height;
  final double width;
  final EdgeInsets padding;
  final int maxLines;
  final String hintText;
  final bool obscureText;

  @override
  _NoneUnderLineTextFieldState createState() => _NoneUnderLineTextFieldState();
}

class _NoneUnderLineTextFieldState extends State<NoneUnderLineTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Padding(
        padding: widget.padding,
        child: TextFormField(
          maxLines: widget.maxLines,
          keyboardType: widget.keyboardType,
          autofocus: true,
          obscureText: widget.obscureText,
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
            filled: false,
            hintStyle: AppTypography.font12,
            prefixIcon: widget.prefixIcon,
            hintText: widget.hintText,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
          style: AppTypography.font17,
          controller: widget.controller,
        ),
      ),
    );
  }
}
