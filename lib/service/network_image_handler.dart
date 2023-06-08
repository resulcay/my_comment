import 'package:flutter/material.dart';

class NetworkImageHandler {
  static Widget imageNetworkHandler(
      BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) return child;
    return Center(
      child: CircularProgressIndicator(
        value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
            : null,
      ),
    );
  }

  static Widget onError() {
    return const Center(
      child: Text(textAlign: TextAlign.center, 'Resim Yüklenemedi'),
    );
  }
}
