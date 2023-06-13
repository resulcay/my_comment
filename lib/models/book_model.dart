import 'dart:convert';
import 'package:flutter/foundation.dart';

// Kitap modelimizdir.
class BookModel {
  final String id;
  final String name;
  final String author;
  final int pages;
  final String imagePath;
  final Map<String, dynamic> comments;
  final Map<String, dynamic> ratings;
  BookModel({
    required this.id,
    required this.name,
    required this.author,
    required this.pages,
    required this.imagePath,
    required this.comments,
    required this.ratings,
  });

  BookModel copyWith({
    String? id,
    String? name,
    String? author,
    int? pages,
    String? imagePath,
    Map<String, dynamic>? comments,
    Map<String, dynamic>? ratings,
  }) {
    return BookModel(
      id: id ?? this.id,
      name: name ?? this.name,
      author: author ?? this.author,
      pages: pages ?? this.pages,
      imagePath: imagePath ?? this.imagePath,
      comments: comments ?? this.comments,
      ratings: ratings ?? this.ratings,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'author': author,
      'pages': pages,
      'imagePath': imagePath,
      'comments': comments,
      'ratings': ratings,
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      id: map['id'] as String,
      name: map['name'] as String,
      author: map['author'] as String,
      pages: map['pages'] as int,
      imagePath: map['imagePath'] as String,
      comments:
          Map<String, dynamic>.from((map['comments'] as Map<String, dynamic>)),
      ratings:
          Map<String, dynamic>.from((map['ratings'] as Map<String, dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory BookModel.fromJson(String source) =>
      BookModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BookModel(id: $id, name: $name, author: $author, pages: $pages, imagePath: $imagePath, comments: $comments, ratings: $ratings)';
  }

  @override
  bool operator ==(covariant BookModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.author == author &&
        other.pages == pages &&
        other.imagePath == imagePath &&
        mapEquals(other.comments, comments) &&
        mapEquals(other.ratings, ratings);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        author.hashCode ^
        pages.hashCode ^
        imagePath.hashCode ^
        comments.hashCode ^
        ratings.hashCode;
  }
}
