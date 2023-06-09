// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:riandgo2/utils/utils.dart';

class BaseTextFormField extends StatefulWidget {
  const BaseTextFormField({
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
    this.outlineColor = AppColors.lightGrey
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
  final Color outlineColor;

  @override
  State<BaseTextFormField> createState() => _BaseTextFormFieldState();
}

class _BaseTextFormFieldState extends State<BaseTextFormField> {
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
          autofocus: false,
          obscureText: widget.obscureText,
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
            hintStyle: AppTypography.font17,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            filled: false,
            hintText: widget.hintText,
            label: widget.controller.text != '' ? Text(widget.hintText) : null,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: widget.outlineColor,
              )
            ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.outlineColor,
                  )
              )

          ),
          style: AppTypography.font17,
          onChanged: (String value) {
            setState(() {});
          },
          controller: widget.controller,
        ),
      ),
    );
  }
}