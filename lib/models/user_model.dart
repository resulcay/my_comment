import 'dart:convert';
import 'package:flutter/foundation.dart';

class UserModel extends ChangeNotifier {
  final String id;
  final String name;
  final String email;
  final List<String> movieComments;
  final List<String> showComments;
  final List<String> bookComments;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.movieComments,
    required this.showComments,
    required this.bookComments,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    List<String>? movieComments,
    List<String>? showComments,
    List<String>? bookComments,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      movieComments: movieComments ?? this.movieComments,
      showComments: showComments ?? this.showComments,
      bookComments: bookComments ?? this.bookComments,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'movieComments': movieComments,
      'showComments': showComments,
      'bookComments': bookComments,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      movieComments: List<String>.from((map['movieComments'] as List<dynamic>)),
      showComments: List<String>.from((map['showComments'] as List<dynamic>)),
      bookComments: List<String>.from((map['bookComments'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, movieComments: $movieComments, showComments: $showComments, bookComments: $bookComments)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        listEquals(other.movieComments, movieComments) &&
        listEquals(other.showComments, showComments) &&
        listEquals(other.bookComments, bookComments);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        movieComments.hashCode ^
        showComments.hashCode ^
        bookComments.hashCode;
  }
}
