import 'package:flutter/material.dart';
import 'package:my_comment/constants/color_constants.dart';

// Basit tema ayarları burada bulunur.
class ThemeService {
  static ThemeData themeConfiguration(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: ColorConstants.primaryColor,
    );
  }
}
