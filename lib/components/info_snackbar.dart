import 'package:flutter/material.dart';

class InfoSnackBar {
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
