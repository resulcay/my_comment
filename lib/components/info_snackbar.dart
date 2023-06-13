import 'package:flutter/material.dart';

class InfoSnackBar {
  // Ekranın altında metin gösterdiğimiz yapıdır.
  static showSnackBar(String content, BuildContext context) {
    if (content != 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(content),
        ),
      );
    }
  }
}
