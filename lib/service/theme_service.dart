import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class ThemeService {
  static ThemeData themeConfiguration(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: ColorConstants.primaryColor,
    );
  }
}
