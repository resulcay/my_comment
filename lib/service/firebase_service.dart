import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_comment/models/book_model.dart';
import 'package:my_comment/models/movie_model.dart';
import 'package:my_comment/models/show_model.dart';
import 'package:my_comment/models/user_model.dart';
import 'package:my_comment/service/user_service.dart';
import 'package:provider/provider.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  getUserDetails(BuildContext context) async {
    User currentUser = _auth.currentUser!;
    return await _firestore
        .collection('users')
        .doc(currentUser.email)
        .get()
        .then((value) {
      dynamic data = value.data();
      if (data != null) {
        UserModel dynamicUser = UserModel.fromMap(data);
        Provider.of<UserService>(context, listen: false).setUser(dynamicUser);
        return value;
      }
      return null;
    });
  }

  Future<List<MovieModel>> getAllMovies() async {
    return await _firestore.collection('movies').get().then((value) {
      return value.docs.map((e) => MovieModel.fromMap(e.data())).toList();
    });
  }

  addMovie() async {
    // String uuid = const Uuid().v4();

    // BookModel model = BookModel(
    //     id: uuid,
    //     name: 'Atomik Alışkanlıklar',
    //     author: 'James Clear',
    //     pages: 352,
    //     imagePath:
    //         'https://cdn.dsmcdn.com/ty583/product/media/images/20221101/14/205058687/611045146/1/1_org_zoom.jpg',
    //     comments: {},
    //     ratings: {});
    // await _firestore
    //     .collection('books')
    //     .add(model.toMap())
    //     .then((value) => print('Added'));
  }

  Future<List<ShowModel>> getAllShows() async {
    return await _firestore.collection('shows').get().then((value) {
      return value.docs.map((e) => ShowModel.fromMap(e.data())).toList();
    });
  }

  Future<List<BookModel>> getAllBooks() async {
    return await _firestore.collection('books').get().then((value) {
      return value.docs.map((e) => BookModel.fromMap(e.data())).toList();
    });
  }

  // getWorkoutByFilter(String filter) async {
  //   await _firestore
  //       .collection('workouts')
  //       .where('title', isEqualTo: filter)
  //       .get()
  //       .then((value) {
  //     List<WorkoutModel> models =
  //         value.docs.map((e) => WorkoutModel.fromMap(e.data())).toList();
  //     workouts = models;
  //     notifyListeners();
  //   });
  // }

  // updateWorkout({
  //   required UserModel user,
  //   Map<String, dynamic>? map,
  //   int? height,
  //   int? weight,
  //   String? name,
  // }) async {
  //   User currentUser = _auth.currentUser!;
  //   await _firestore.collection('users').doc(currentUser.email).update({
  //     'workoutInfo': map ?? user.workoutInfo,
  //     'height': height ?? user.height,
  //     'weight': weight ?? user.weight,
  //     'name': name ?? user.name,
  //   });
  // }
}
