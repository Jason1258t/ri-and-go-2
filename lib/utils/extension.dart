// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:riandgo2/utils/utils.dart';

extension ContextExt on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  void showMessage({required String text}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: AppTypography.font14.copyWith(
            color: AppColors.white,
          ),
          textAlign: TextAlign.center,
        ),
        duration: const Duration(seconds: 1),
        backgroundColor: AppColors.black,
      ),
    );
  }
}

extension ToTimeFormat on int {
  String get toSecondsFormat {
    final toSeconds = this ~/ 1000;
    return '00:${toSeconds < 10 ? '0$toSeconds' : toSeconds}';
  }
}

extension StringExt on String {

  String get firstSymbol => substring(0, 1);

}

extension DioExt on DioError {
  bool get isConnection =>
      error is SocketException ||
      type == DioErrorType.connectTimeout ||
      type == DioErrorType.sendTimeout;
}
