import 'package:flutter/material.dart';

abstract class CustomSnackBar {
  static void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          color: Color(0xff474763),
        ),
      ),
      backgroundColor: Color(0xffFFAC7D),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}