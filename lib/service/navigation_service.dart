import 'package:flutter/foundation.dart';

class NavigationService extends ChangeNotifier {
  int pageIndex = 0;

  void changePageIndex(int value) {
    pageIndex = value;
    notifyListeners();
  }
}
