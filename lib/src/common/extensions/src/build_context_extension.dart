import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;

  Size get size => MediaQuery.sizeOf(this);
  double get width => size.width;
  double get height => size.height;
}
