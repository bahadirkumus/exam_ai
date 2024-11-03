import 'package:flutter/material.dart';

class AppHelpers {
  // Light-Dark Mode
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}