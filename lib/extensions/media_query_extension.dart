import 'package:flutter/material.dart';

// Bulunan bağlama cihazın yüksekliğin ve genişliğini dinamik bir şekilde bildirmek için bir genişletme işlemidir.
extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;
}
