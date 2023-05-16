import 'package:flutter/material.dart';
import 'package:riandgo2/utils/colors.dart';
import 'package:riandgo2/widgets/text_fields/noneUnderLine_text_field.dart';

class TexrField extends StatefulWidget {
  TexrField({
    Key? key,
    required this.controller,
    required this.keyboardType,
    required this.maxLines,
    required this.hintText,
    this.height = 50,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLines;
  final String hintText;
  double? height;

  @override
  _TextFieldState createState() => _TextFieldState();
}

class _TextFieldState extends State<TexrField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      height: widget.height,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: NoneUnderLineTextField(
        height: 50,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        hintText: widget.hintText,
        maxLines: widget.maxLines,
      ),
    );
  }
}