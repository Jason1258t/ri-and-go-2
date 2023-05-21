// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:riandgo2/utils/utils.dart';

class BasePasswordField extends StatefulWidget {
  const BasePasswordField({
    Key? key,
    required this.controller,
    required this.keyboardType,
    this.height = 80,
    this.width = double.infinity,
    this.padding = const EdgeInsets.all(10),
    this.maxLines = 1,
    this.hintText = '',
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
  final Color outlineColor;

  @override
  State<BasePasswordField> createState() => _BasePasswordFieldState();
}

class _BasePasswordFieldState extends State<BasePasswordField> {
  bool visible = true;

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
          obscureText: visible,
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
              hintStyle: AppTypography.font17,

              // fillColor: AppColors.grey8E8E93,
              prefixIcon: widget.prefixIcon,
              suffixIcon: IconButton(icon: const Icon(Icons.remove_red_eye_outlined), onPressed: () {setState(() {
                visible = !visible;
              });},),
              filled: false,
              hintText: widget.hintText,
              label: widget.controller.text != '' ? Text(widget.hintText) : null,
              // border: const OutlineInputBorder(
              //   borderRadius: BorderRadius.all(
              //     Radius.circular(10.0),
              //   ),
              // ),
              // focusedBorder: OutlineInputBorder(
              //   //borderRadius: BorderRadius.circular(10.0),
              //   borderSide: const BorderSide(
              //     color: AppColors.blue,
              //   ),
              // ),
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

