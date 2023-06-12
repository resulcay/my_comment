import 'package:flutter/material.dart';
import '../models/user_model.dart';

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
