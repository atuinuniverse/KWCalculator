import 'dart:ui';

import 'package:flutter/material.dart';

class KWTheme {
  static final KWTheme _instance = KWTheme._internal();

  factory KWTheme() {
    return _instance;
  }

  KWTheme._internal();

  final Color _primaryColor = const Color(0xff008080);
  final Color _textColor = const Color(0xff1D262D);
  final Color _backgroundColor = const Color(0xffEEE7E4);
  final Color _alertColor = const Color(0xffFF8F00);

  Color get primaryColor => _primaryColor;
  Color get textColor => _textColor;
  Color get backgroundColor => _backgroundColor;
  Color get alertColor => _alertColor;
}