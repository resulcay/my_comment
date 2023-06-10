import 'package:my_comment/enums/category_enum.dart';

extension ResponseCategoryName on Category {
  String get name {
    switch (this) {
      case Category.movie:
        return 'movie';
      case Category.show:
        return 'show';
      case Category.book:
        return 'book';
      default:
        return 'movie';
    }
  }
}
