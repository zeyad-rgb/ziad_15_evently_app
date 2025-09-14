import 'package:flutter/material.dart';

abstract class ThemesManager {
  Color get primaryColor;
  Color get secondryColor;
  Color get background;
  Color get textColor;
  ThemeData get themeData;
}
