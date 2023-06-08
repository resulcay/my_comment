// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ShowModel {
  final String id;
  final String name;
  final int episodes;
  final int season;
  final String genre;
  final String imagePath;
  final Map<String, dynamic> comments;
  final Map<String, dynamic> ratings;
  ShowModel({
    required this.id,
    required this.name,
    required this.episodes,
    required this.season,
    required this.genre,
    required this.imagePath,
    required this.comments,
    required this.ratings,
  });

  ShowModel copyWith({
    String? id,
    String? name,
    int? episodes,
    int? season,
    String? genre,
    String? imagePath,
    Map<String, dynamic>? comments,
    Map<String, dynamic>? ratings,
  }) {
    return ShowModel(
      id: id ?? this.id,
      name: name ?? this.name,
      episodes: episodes ?? this.episodes,
      season: season ?? this.season,
      genre: genre ?? this.genre,
      imagePath: imagePath ?? this.imagePath,
      comments: comments ?? this.comments,
      ratings: ratings ?? this.ratings,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'episodes': episodes,
      'season': season,
      'genre': genre,
      'imagePath': imagePath,
      'comments': comments,
      'ratings': ratings,
    };
  }

  factory ShowModel.fromMap(Map<String, dynamic> map) {
    return ShowModel(
      id: map['id'] as String,
      name: map['name'] as String,
      episodes: map['episodes'] as int,
      season: map['season'] as int,
      genre: map['genre'] as String,
      imagePath: map['imagePath'] as String,
      comments:
          Map<String, dynamic>.from((map['comments'] as Map<String, dynamic>)),
      ratings:
          Map<String, dynamic>.from((map['ratings'] as Map<String, dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShowModel.fromJson(String source) =>
      ShowModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ShowModel(id: $id, name: $name, episodes: $episodes, season: $season, genre: $genre, imagePath: $imagePath, comments: $comments, ratings: $ratings)';
  }

  @override
  bool operator ==(covariant ShowModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.episodes == episodes &&
        other.season == season &&
        other.genre == genre &&
        other.imagePath == imagePath &&
        mapEquals(other.comments, comments) &&
        mapEquals(other.ratings, ratings);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        episodes.hashCode ^
        season.hashCode ^
        genre.hashCode ^
        imagePath.hashCode ^
        comments.hashCode ^
        ratings.hashCode;
  }
}
