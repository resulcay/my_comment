import 'package:flutter/material.dart';

import '../models/user_model.dart';

class UserService extends ChangeNotifier {
  UserModel? user;

  setUser(UserModel? model) {
    user = model;
    notifyListeners();
  }

  changeUserProperties({
    String? email,
    String? name,
    Map<String, dynamic>? workoutInfo,
  }) {
    user = user?.copyWith(
      email: email,
      name: name,
    );
    notifyListeners();
  }
}
