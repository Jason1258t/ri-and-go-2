// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:riandgo2/utils/utils.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
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
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType keyboardType;
  final Icon? prefixIcon;
  final double height;
  final double width;
  final EdgeInsets padding;
  final int maxLines;
  final String hintText;
  final bool obscureText;

  @override
  _PasswordTextFormFieldState createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool vizible = false;

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
          obscureText: vizible,
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
              hintStyle: AppTypography.font17,
              suffixIcon: IconButton(
                icon: Icon(Icons.remove_red_eye_outlined),
                onPressed: () {setState(() {
                  vizible = !vizible;
                });},
              ),
              prefixIcon: widget.prefixIcon,
              filled: false,
              hintText: widget.hintText,
              label: widget.controller.text != '' ? Text(widget.hintText) : null,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.lightGrey,
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
