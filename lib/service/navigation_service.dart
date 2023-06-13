import 'package:flutter/foundation.dart';

class NavigationService extends ChangeNotifier {
  // Uygulama açıldığında ilk bu indexteki ekran gösterilir.
  int pageIndex = 0;

  void changePageIndex(int value) {
    pageIndex = value;
    notifyListeners();
  }
}
