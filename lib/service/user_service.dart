import 'package:flutter/material.dart';
import 'package:my_comment/models/user_model.dart';

// Tüm uygulamada kullanılacak kullanıcı nesnesi değiştiğinde burada yönetilir.
class UserService extends ChangeNotifier {
  UserModel? user;

  setUser(UserModel? model) {
    user = model;
    notifyListeners();
  }

  changeUserProperties({
    String? id,
    String? name,
    String? email,
    List<String>? movieComments,
    List<String>? showComments,
    List<String>? bookComments,
  }) {
    user = user?.copyWith(
      id: id,
      name: name,
      email: email,
      movieComments: movieComments,
      showComments: showComments,
      bookComments: bookComments,
    );
    notifyListeners();
  }
}
