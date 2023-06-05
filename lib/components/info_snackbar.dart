import 'package:flutter/material.dart';

class InfoSnackBar {
  //
  // Global bir uyarı gösterme Widget'ını ekranın en altında gösterir.
  //
  static showSnackBar(String content, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }
}
