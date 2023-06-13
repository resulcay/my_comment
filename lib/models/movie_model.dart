import 'dart:convert';
import 'package:flutter/foundation.dart';

// Film modelimizdir.
class MovieModel {
  final String id;
  final String name;
  final int duration;
  final int year;
  final double imdb;
  final String imagePath;
  final Map<String, dynamic> comments;
  final Map<String, dynamic> ratings;
  MovieModel({
    required this.id,
    required this.name,
    required this.duration,
    required this.year,
    required this.imdb,
    required this.imagePath,
    required this.comments,
    required this.ratings,
  });

  MovieModel copyWith({
    String? id,
    String? name,
    int? duration,
    int? year,
    double? imdb,
    String? imagePath,
    Map<String, dynamic>? comments,
    Map<String, dynamic>? ratings,
  }) {
    return MovieModel(
      id: id ?? this.id,
      name: name ?? this.name,
      duration: duration ?? this.duration,
      year: year ?? this.year,
      imdb: imdb ?? this.imdb,
      imagePath: imagePath ?? this.imagePath,
      comments: comments ?? this.comments,
      ratings: ratings ?? this.ratings,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'duration': duration,
      'year': year,
      'imdb': imdb,
      'imagePath': imagePath,
      'comments': comments,
      'ratings': ratings,
    };
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map['id'] as String,
      name: map['name'] as String,
      duration: map['duration'] as int,
      year: map['year'] as int,
      imdb: map['imdb'] as double,
      imagePath: map['imagePath'] as String,
      comments:
          Map<String, dynamic>.from((map['comments'] as Map<String, dynamic>)),
      ratings:
          Map<String, dynamic>.from((map['ratings'] as Map<String, dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieModel.fromJson(String source) =>
      MovieModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MovieModel(id: $id, name: $name, duration: $duration, year: $year, imdb: $imdb, imagePath: $imagePath, comments: $comments, ratings: $ratings)';
  }

  @override
  bool operator ==(covariant MovieModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.duration == duration &&
        other.year == year &&
        other.imdb == imdb &&
        other.imagePath == imagePath &&
        mapEquals(other.comments, comments) &&
        mapEquals(other.ratings, ratings);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        duration.hashCode ^
        year.hashCode ^
        imdb.hashCode ^
        imagePath.hashCode ^
        comments.hashCode ^
        ratings.hashCode;
  }
}
