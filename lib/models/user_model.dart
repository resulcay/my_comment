import 'dart:convert';

import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  UserModel? user;
  final String id;
  UserModel({
    required this.id,
  });

  copyWith({
    String? id,
  }) {
    user = UserModel(id: id ?? this.id);
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(id: $id)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
